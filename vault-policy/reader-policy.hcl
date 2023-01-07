path "sys/mounts"
{
  capabilities = ["read"]
}
path "kv/*"
{
  capabilities = ["list"]
}
path "kv/data/*"
{
  capabilities = ["read"]
}
