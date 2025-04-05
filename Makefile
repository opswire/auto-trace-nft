PHONY: deploy

deploy:
	npx hardhat run scripts/deploy.js --network polygon
