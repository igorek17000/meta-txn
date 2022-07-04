const DiANFT = artifacts.require("DiANFT");
const biconomyForwarder = require("../list/biconomyForwarder.json");

module.exports = function (deployer, network) {
  const getBiconomyForwarderByNetwork = biconomyForwarder[network];
  if (getBiconomyForwarderByNetwork) {
    deployer.deploy(DiANFT, "DiANFT", "DFT", "ipfs://QmYbkFTXmoeZ8n4DSQUmnjsYv8S5go9E5kQoirZvqrBzXR/",getBiconomyForwarderByNetwork);
  } else {
    console.log("No Biconomy Forwarder Found in the desired network!");
  }
};
