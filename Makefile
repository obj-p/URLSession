.PHONY: all
all: clean
	@$(MAKE) -C Apps

.PHONY: brew
brew:
	@brew bundle --no-lock

.PHONY: clean
clean:
	@$(MAKE) -C Apps clean

.PHONY: pre-commit
pre-commit:
	pre-commit install
