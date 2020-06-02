# System mounts
path "sys/auth/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "sys/auth*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "sys/policies/acl/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "sys/policies/acl" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "sys/mounts" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "sys/mounts/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "sys/health" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "sys/capabilities" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

path "sys/capabilities-self" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# Auth methods
path "auth/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# PKI
path "pki/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}
path "pki_int/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}

# Secrets
path "secret/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}