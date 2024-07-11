variable "origin_domain_name" {
  description = "The domain name of the origin."
  type        = string
}

variable "origin_id" {
  description = "A unique identifier for the origin."
  type        = string
}

variable "http_port" {
  description = "The HTTP port the custom origin listens on."
  default     = 80
}

variable "https_port" {
  description = "The HTTPS port the custom origin listens on."
  default     = 443
}

variable "origin_protocol_policy" {
  description = "The protocol the origin expects the traffic to be."
  default     = "http-only"
}

variable "origin_ssl_protocols" {
  description = "The SSL/TLS protocols that could be used when talking to the origin."
  type        = list(string)
  default     = ["TLSv1", "TLSv1.1", "TLSv1.2"]
}

variable "enabled" {
  description = "Whether the distribution is enabled to accept end user requests for content."
  default     = true
}

variable "is_ipv6_enabled" {
  description = "Whether the IPv6 is enabled for the distribution."
  default     = true
}

variable "comment" {
  description = "Any comments you want to include about the distribution."
  default     = "CDN for templateGames"
}

variable "default_root_object" {
  description = "The object that you want CloudFront to request from your origin."
  default     = "index.html"
}

variable "allowed_methods" {
  description = "List of allowed methods (e.g., GET, PUT, POST, DELETE, HEAD)."
  type        = list(string)
  default     = ["GET", "HEAD"]
}

variable "cached_methods" {
  description = "List of cached methods (e.g., GET, PUT, POST, DELETE, HEAD)."
  type        = list(string)
  default     = ["GET", "HEAD"]
}

variable "forward_query_string" {
  description = "Whether you want CloudFront to forward query strings to the origin."
  default     = true
}

variable "cookie_forwarding" {
  description = "Specifies how CloudFront forwards cookies to the origin."
  default     = "none"
}

variable "viewer_protocol_policy" {
  description = "Allow only HTTPS or redirect HTTP to HTTPS."
  default     = "redirect-to-https"
}

variable "min_ttl" {
  description = "The minimum amount of time you want objects to stay in CloudFront caches."
  default     = 0
}

variable "default_ttl" {
  description = "The default amount of time you want objects to stay in CloudFront caches."
  default     = 604800  # 7 days
}

variable "max_ttl" {
  description = "The maximum amount of time you want objects to stay in CloudFront caches."
  default     = 31536000  # 1 year
}

variable "geo_restriction_type" {
  description = "The method that you want to use to restrict distribution of your content by country."
  default     = "none"
}

variable "restricted_countries" {
  description = "The countries in which you want CloudFront either to distribute your content (whitelist) or not distribute your content (blacklist)."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "price_class" {
  description = "The CloudFront price class for the distribution. One of `PriceClass_All`, `PriceClass_200`, or `PriceClass_100`."
  default     = "PriceClass_100"
}

variable "waf_acl_id" {
  description = "The WAF ACL ID to associate with the CloudFront distribution."
  default     = null
}

variable "country_codes" {
  description = "The countries in which you want to apply rateLimitRule. If you specify `*`, CloudFront applies rateLimitRule to all countries"
  type        = list(string)
  default     = ["*"]
}

variable "user_agent_regex_string" {
  description = "The regular expression pattern that you want AWS WAF to search for in web requests, the location in requests that you want AWS WAF to search, and other settings."
  type = string
  default     = ".*"
}

variable "rate_limit" {
  description = "The maximum allowed requests per 5-minute period for an IP"
  default     = 2000
}