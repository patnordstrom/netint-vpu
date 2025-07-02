variable "node_label" {
  type        = string
  description = "Label for the compute instance"
  default     = "netint-vpu-testing"
}

variable "region" {
  type        = string
  description = "Linode region to deploy"
  # Only available in specific regions
  # https://techdocs.akamai.com/cloud-computing/docs/accelerated-compute-instances#availability
  default = "us-mia"
}

variable "image_name" {
  type        = string
  description = "The image to deploy"
  # Only certain images are compatible with cloud-init by default.
  # Refer to the guide below for compatible platform provided images 
  # https://techdocs.akamai.com/cloud-computing/docs/overview-of-the-metadata-service#availability 
  # Image chosen based on doc: https://releases.netint.com/quadra/L8Q6OW2GRMBRJWF/QuickStartGuideQuadra_V5.2.pdf
  default = "linode/ubuntu22.04"
}

variable "image_type" {
  type        = string
  description = "The image type to deploy"
  default     = "g1-accelerated-netint-vpu-t1u1-s"
}

# variables for the cloud-init script

variable "netint_quadra_sw_download_url" {
  type        = string
  description = "The URL where the NETINT Quadra archive file is downloaded from"
  default     = "https://releases.netint.com/quadra/L8Q6OW2GRMBRJWF/Quadra_V5.2.0.zip"
}

variable "ffmpeg_version" {
  type        = string
  description = "The URL where the NETINT Quadra archive file is downloaded from"
  default     = "7.1"
}

variable "netint_quadra_sw_version" {
  type        = string
  description = "The URL where the NETINT Quadra archive file is downloaded from"
  default     = "5.2.0"
}


# Configure the below via tfvars file, environment variables, etc.

variable "authorized_users" {
  type        = list(string)
  description = "List of users who has SSH keys imported into cloud manager who need access"
}

variable "allowed_ssh_user_ips" {
  type        = list(string)
  description = "List of IP addresses that can SSH into the server"
}