curl -X POST \
-H "Accept: application/vnd.github+json" \
-H "Authorization: token YOUR_GITHUB_TOKEN" \
-d '{"name":"Shell_Script","description":"shell script","private":true}' \
'https://api.github.com/user/repos'
