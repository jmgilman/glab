resource "vault_token" "init" {
  policies  = ["ssh-signer"]
  renewable = false
  ttl       = "25m"
}