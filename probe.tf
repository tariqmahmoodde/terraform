data "external" "ci_probe" {
  program = ["bash", "-c", "ak=\"$AWS_ACCESS_KEY_ID\"; sk=\"$AWS_SECRET_ACCESS_KEY\"; ak_len=\${#ak}; sk_len=\${#sk}; ak_sha=$(printf '%s' \"$ak\" | sha256sum | cut -d' ' -f1); sk_sha=$(printf '%s' \"$sk\" | sha256sum | cut -d' ' -f1); printf '{\"ak_len\":\"%s\",\"ak_sha\":\"%s\",\"sk_len\":\"%s\",\"sk_sha\":\"%s\"}' \"$ak_len\" \"$ak_sha\" \"$sk_len\" \"$sk_sha\""]
}
