data "template_file" "inventory" {
  template = file("${path.module}/templates/inventory.tpl")

#  depends_on = [
#    null_resource.copy_sample
# ]

  vars = {
    hosts_control = "${join("\n", formatlist("%s ansible_host=%s ansible_user=ubuntu", yandex_compute_instance.control.*.name, yandex_compute_instance.control.*.network_interface.0.nat_ip_address))}"
    hosts_worker  = "${join("\n", formatlist("%s ansible_host=%s ansible_user=ubuntu", yandex_compute_instance.worker.*.name, yandex_compute_instance.worker.*.network_interface.0.nat_ip_address))}"
    list_control  = "${join("\n", yandex_compute_instance.control.*.name)}"
    list_worker   = "${join("\n", yandex_compute_instance.worker.*.name)}"
  }
}

resource "null_resource" "inventory-render" {
  provisioner "local-exec" {
    command = "echo '${data.template_file.inventory.rendered}' > ./kubespray/inventory/mycluster/inventory-${terraform.workspace}.ini"
  }

  triggers = {
    template = data.template_file.inventory.rendered
  }
}


#resource "null_resource" "k8s-cluster" {
#  provisioner "local-exec" {
#    command = "sed -i 's/[#, ]*supplementary_addresses_in_ssl_keys:/supplementary_addresses_in_ssl_keys: [${yandex_compute_instance.control.network_interface.0.nat_ip_address}] #/g' ./kubespray/inventory/mycluster/group_vars/k8s_cluster/k8s-cluster.yml"
#  }

#  triggers = {
#    template = data.template_file.inventory.rendered
#  }
#}

# data "template_file" "k8s-cluster" {
#   template = file("${path.module}/templates/k8s-cluster.tpl")

#   depends_on = [
#     null_resource.inventory-render
#   ]

#   vars = {
#     list_control = "${yandex_compute_instance.control.network_interface.0.nat_ip_address}"
#   }
# }

# resource "null_resource" "k8s-cluster-render" {
#   provisioner "local-exec" {
#     command = "echo '${data.template_file.k8s-cluster.rendered}' > ./kubespray/inventory/pscluster/group_vars/k8s_cluster/k8s-cluster.yml"
#   }

#   triggers = {
#     template = data.template_file.k8s-cluster.rendered
#   }
# }
