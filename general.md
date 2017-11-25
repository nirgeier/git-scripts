# General scriptlets

# log branches with dates, committer, message and more
git log                     \
        --graph             \
        --abbrev-commit     \
        --decorate          \
        --all               \
        --format=format:"%C(bold blue)%h%C(reset)   \
                    - %C(bold cyan)%aD%C(dim white) \
                    - %an%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n %C(white)%s%C(reset)"