 def deps do
  [
    {:tentacat, "~> 2.0"}
  ]
end
iex> client = Tentacat.Client.new
%Tentacat.Client{auth: nil, endpoint: "https://api.github.com/"}
iex> Tentacat.Users.find client, "edgurgel"
{200,
 %{"avatar_url" => "https://avatars0.githubusercontent.com/u/30873?v=4",
   "bio" => "INSUFFICIENT DATA FOR MEANINGFUL ANSWER",
   "blog" => "http://gurgel.me", "company" => nil,
   "created_at" => "2008-10-24T17:05:04Z", "email" => nil,
   "events_url" => "https://api.github.com/users/edgurgel/events{/privacy}",
   "followers" => 220,
   "followers_url" => "https://api.github.com/users/edgurgel/followers",
   "following" => 75,
   "following_url" => "https://api.github.com/users/edgurgel/following{/other_user}",
   "gists_url" => "https://api.github.com/users/edgurgel/gists{/gist_id}",
   "gravatar_id" => "", "hireable" => nil,
   "html_url" => "https://github.com/edgurgel", "id" => 30873,
   "location" => "Wellington, New Zealand", "login" => "edgurgel",
   "name" => "Eduardo Gurgel",
   "organizations_url" => "https://api.github.com/users/edgurgel/orgs",
   "public_gists" => 13, "public_repos" => 59,
   "received_events_url" => "https://api.github.com/users/edgurgel/received_events",
   "repos_url" => "https://api.github.com/users/edgurgel/repos",
   "site_admin" => false,
   "starred_url" => "https://api.github.com/users/edgurgel/starred{/owner}{/repo}",
   "subscriptions_url" => "https://api.github.com/users/edgurgel/subscriptions",
   "type" => "User", "updated_at" => "2018-02-05T23:24:42Z",
   "url" => "https://api.github.com/users/edgurgel"},
 %HTTPoison.Response{body: %{"avatar_url" => "https://avatars0.githubusercontent.com/u/30873?v=4",
    "bio" => "INSUFFICIENT DATA FOR MEANINGFUL ANSWER",
    "blog" => "http://gurgel.me", "company" => nil,
    "created_at" => "2008-10-24T17:05:04Z", "email" => nil,
    "events_url" => "https://api.github.com/users/edgurgel/events{/privacy}",
    "followers" => 220,
    "followers_url" => "https://api.github.com/users/edgurgel/followers",
    "following" => 75,
    "following_url" => "https://api.github.com/users/edgurgel/following{/other_user}",
    "gists_url" => "https://api.github.com/users/edgurgel/gists{/gist_id}",
    "gravatar_id" => "", "hireable" => nil,
    "html_url" => "https://github.com/edgurgel", "id" => 30873,
    "location" => "Wellington, New Zealand", "login" => "edgurgel",
    "name" => "Eduardo Gurgel",
    "organizations_url" => "https://api.github.com/users/edgurgel/orgs",
    "public_gists" => 13, "public_repos" => 59,
    "received_events_url" => "https://api.github.com/users/edgurgel/received_events",
    "repos_url" => "https://api.github.com/users/edgurgel/repos",
    "site_admin" => false,
    "starred_url" => "https://api.github.com/users/edgurgel/starred{/owner}{/repo}",
    "subscriptions_url" => "https://api.github.com/users/edgurgel/subscriptions",
    "type" => "User", "updated_at" => "2018-02-05T23:24:42Z",
    "url" => "https://api.github.com/users/edgurgel"},
  headers: [{"Date", "Mon, 05 Feb 2018 23:25:36 GMT"},
   {"Content-Type", "application/json; charset=utf-8"},
   {"Content-Length", "1187"}, {"Server", "GitHub.com"}, {"Status", "200 OK"},
   {"X-RateLimit-Limit", "60"}, {"X-RateLimit-Remaining", "59"},
   {"X-RateLimit-Reset", "1517876736"},
   {"Cache-Control", "public, max-age=60, s-maxage=60"}, {"Vary", "Accept"},
   {"ETag", "\"ec2653a252e614a96afacfaeb88d0c39\""},
   {"Last-Modified", "Mon, 05 Feb 2018 23:24:42 GMT"},
   {"X-GitHub-Media-Type", "github.v3; format=json"},
   {"Access-Control-Expose-Headers",
    "ETag, Link, Retry-After, X-GitHub-OTP, X-RateLimit-Limit, X-RateLimit-Remaining, X-RateLimit-Reset, X-OAuth-Scopes, X-Accepted-OAuth-Scopes, X-Poll-Interval"},
   {"Access-Control-Allow-Origin", "*"},
   {"Content-Security-Policy", "default-src 'none'"},
   {"Strict-Transport-Security",
    "max-age=31536000; includeSubdomains; preload"},
   {"X-Content-Type-Options", "nosniff"}, {"X-Frame-Options", "deny"},
   {"X-XSS-Protection", "1; mode=block"}, {"X-Runtime-rack", "0.030182"},
   {"Vary", "Accept-Encoding"},
   {"X-GitHub-Request-Id", "054D:2BC4A:82C2C:A4560:5A78E7EF"}],
  request_url: "https://api.github.com/users/edgurgel", status_code: 200}}
 name:GITHUB_WORKFLOW
 -env: APi_KEY:process.env()
 -For each:'$.respomd() '.
 }
defineComponent
({
  async run({ steps, $ }) {
    await $.respond({
      status: 200,
      headers: { "Authorization": "Bearer" },
      body: { message: "💦🔞🖕" }, // This can be any string, object, Buffer, or Readable stream
    });
  }
});
