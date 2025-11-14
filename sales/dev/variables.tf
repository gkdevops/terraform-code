variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string

  validation {
    condition     = length(var.bucket_name) >= 3 && length(var.bucket_name) <= 63
    error_message = "The bucket_name must be between 3 and 63 characters long and can only contain lowercase letters, numbers, and hyphens."
  }
}

variable "acl" {
  description = "The ACL (Access Control List) for the bucket"
  type        = string
  default     = "private"

  validation {
    condition     = contains(["private", "public-read", "public-read-write", "authenticated-read"], var.acl)
    error_message = "The acl must be one of: private, public-read, public-read-write, or authenticated-read."
  }
}

variable "force_destroy" {
  description = "Whether to forcefully destroy the bucket even if it contains objects"
  default     = false
}

variable "enable_versioning" {
  description = "Enable versioning for the S3 bucket"
  type        = bool
  default     = false

  validation {
    condition     = var.enable_versioning == true || var.enable_versioning == false
    error_message = "enable_versioning must be a boolean value (true or false)."
  }
}

variable "tags" {
  description = "A map of tags to assign to the bucket"
  type        = map(string)
  default     = {}

  validation {
    condition     = length(var.tags) == 0 || alltrue([for k, v in var.tags : length(k) > 0 && length(v) > 0])
    error_message = "All tag keys and values must be non-empty strings."
  }
}

