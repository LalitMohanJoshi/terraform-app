# create oci compartement - it is similar like - project, resource group

resource "oci_identity_compartment" "node_compartment" {
  compartment_id = var.oci_root_compartment_id
  name           = "node-app-compartement"
  description    = "Compartment for node app resources"
  enable_delete  = true
}

# create virtual cloud network

resource "oci_core_vcn" "node_vcn" {
  cidr_block     = var.oci_vcn_cidr_block
  compartment_id = oci_identity_compartment.node_compartment.id
  is_ipv6enabled = false
  display_name   = "node-app-vcn"
   dns_label    = "vcn1"
}

# create dhcp - dynamic host control protocol

resource "oci_core_dhcp_options" "node_dhcp" {
  compartment_id = oci_identity_compartment.node_compartment.id
  vcn_id         = oci_core_vcn.node_vcn.id
  display_name   = "node-app-dhcp"

  options {
    type        = "DomainNameServer"
    server_type = "VcnLocalPlusInternet"
  }

  options {
    type                = "SearchDomain"
    search_domain_names = ["webduby.com"]
  }
}

# define ingress / egress security rules

resource "oci_core_security_list" "node_sl" {
  compartment_id = oci_identity_compartment.node_compartment.id
  vcn_id         = oci_core_vcn.node_vcn.id
  display_name   = "node-app-security-list"

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      max = 22
      min = 22
    }
  }

  ingress_security_rules {
    protocol = "6"
    source   = "0.0.0.0/0"

    tcp_options {
      max = 80
      min = 80
    }
  }

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
  }
}

# create internt gateway

resource "oci_core_internet_gateway" "node_internet_gateway" {
  compartment_id = oci_identity_compartment.node_compartment.id
  vcn_id         = oci_core_vcn.node_vcn.id
  display_name   = "node-app-internet-gateway"

  enabled = true
}

# create route table fo internet gateway

resource "oci_core_route_table" "node_ig_route_table" {
  compartment_id = oci_identity_compartment.node_compartment.id
  vcn_id         = oci_core_vcn.node_vcn.id
  display_name   = "node-app-route-table"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.node_internet_gateway.id
  }
}

# create public subnet

resource "oci_core_subnet" "node_public_subnet" {
  compartment_id = oci_identity_compartment.node_compartment.id
  vcn_id         = oci_core_vcn.node_vcn.id
  cidr_block     = var.oci_vcn_public_subnet_cidr_block

  display_name = "node-app-public-subnet"
  dns_label    = "terraformSubnet"

  route_table_id      = oci_core_route_table.node_ig_route_table.id
  dhcp_options_id     = oci_core_dhcp_options.node_dhcp.id
  security_list_ids   = ["${oci_core_security_list.node_sl.id}"]
  availability_domain = "${lookup(data.oci_identity_availability_domains.node_availability_domains.availability_domains[var.oci_availability_domain - 1], "name")}"
}
