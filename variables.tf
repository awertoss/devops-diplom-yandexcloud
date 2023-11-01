# Заменить на ID своего облака
# https://console.cloud.yandex.ru/cloud?section=overview
variable "yandex_cloud_id" {
  default = "b1*****34hrh7s"
}

# Заменить на Folder своего облака
# https://console.cloud.yandex.ru/cloud?section=overview
variable "yandex_folder_id" {
  default = "b1gd****57v2h14"
}


variable "subnet-zones" {
  type    = list(string)
  default = ["ru-central1-a", "ru-central1-b", "ru-central1-c"]
}

variable "cidr" {
  type    = map(list(string))
  default = {
    stage = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]    
  }
}
