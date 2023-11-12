locals {
  vm_cores = {
    stage = 2
    prod  = 4
  }
  vm_memory = {
    stage = 2
    prod  = 4
  }
  instance_count = {
    stage = 1
    prod  = 2
  }
}

resource "yandex_compute_instance" "control" {
  count = 1
  name = "control-${count.index}"
# name = "control-1"
  zone  = "${var.subnet-zones[count.index]}"



  resources {
    cores  = 2
    memory = 4
  }
  scheduling_policy {
  preemptible = true  // Прерываемая ВМ
  }
  network_interface {
    subnet_id  = "${yandex_vpc_subnet.subnet-zones[count.index].id}"
    nat        = true
  }
  boot_disk {
    initialize_params {
      image_id = "fd8clogg1kull9084s9o"
      type     = "network-hdd"
      size     = "50"
    }
  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "worker" {
  count = 2
  name  = "worker-${count.index}"
  zone  = "${var.subnet-zones[count.index]}"
 scheduling_policy {
  preemptible = true  // Прерываемая ВМ
  }
 labels = {
    index = "${count.index}"
  }
  resources {
    cores  = 2
    memory = 4
  }
network_interface {
    subnet_id  = "${yandex_vpc_subnet.subnet-zones[count.index].id}"
    nat        = true
  }


  boot_disk {
    initialize_params {
      image_id = "fd8gu48shgedqb1ubago"
      type     = "network-hdd"
      size     = "50"
    }
  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}
