// SPDX-License-Identifier: GPL-3.0

// Amended by HashLips
/**
    !Disclaimer!
    These contracts have been used to create tutorials,
    and was created for the purpose to teach people
    how to create smart contracts on the blockchain.
    please review this code on your own before using any of
    the following code for production.
    HashLips will not be liable in any way if for the use 
    of the code. That being said, the code has been tested 
    to the best of the developers' knowledge to work as intended.
*/

pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@opengsn/contracts/src/BaseRelayRecipient.sol";

contract DiANFT is ERC721Enumerable, Ownable, BaseRelayRecipient {
  using Strings for uint256;

  string public baseURI;
  string public baseExtension = ".json";
  uint256 public cost = 0.0001 ether;
  uint256 public maxSupply = 1000;
  uint256 public maxMintAmount = 1;
  bool public paused = false;
  mapping(address => bool) public whitelisted;
  //address public override owner;
  string data;
  // modifier onlyOwner() {
  //   require(owner == _msgSender(), "");
  //   _;
  //   }

  constructor(
    string memory _name,
    string memory _symbol,
    string memory _initBaseURI,
    address _trustedForwarder
  ) ERC721(_name, _symbol) {
    setBaseURI(_initBaseURI);
    _setTrustedForwarder(_trustedForwarder);
    mint(_msgSender(), 1);
    data = "Hello Metatransaction";
  }

  function _msgSender() internal view override(Context, BaseRelayRecipient)
      returns (address sender) {
      sender = BaseRelayRecipient._msgSender();
  }

  function _msgData() internal view override(Context, BaseRelayRecipient)
      returns (bytes calldata) {
      return BaseRelayRecipient._msgData();
  }

  // internal
  function _baseURI() internal view virtual override returns (string memory) {
    return baseURI;
  }

function versionRecipient() external pure override returns (string memory) {
        return "1";
    }

//    function setTrustForwarder(address _trustedForwarder) public onlyOwner {
//         _setTrustedForwarder(_trustedForwarder);
//     }

  // public
  function mint(address _to, uint256 _mintAmount) public {
    uint256 supply = totalSupply();
    require(!paused);
    require(_mintAmount > 0);
    require(_mintAmount <= maxMintAmount);
    require(supply + _mintAmount <= maxSupply);

    // if (_msgSender() != owner()) {
    //     if(whitelisted[_msgSender()] != true) {
    //       require(msg.value >= cost * _mintAmount);
    //     }
    // }

    for (uint256 i = 1; i <= _mintAmount; i++) {
      _safeMint(_to, supply + i);
    }
  }

  function walletOfOwner(address _owner)
    public
    view
    returns (uint256[] memory)
  {
    uint256 ownerTokenCount = balanceOf(_owner);
    uint256[] memory tokenIds = new uint256[](ownerTokenCount);
    for (uint256 i; i < ownerTokenCount; i++) {
      tokenIds[i] = tokenOfOwnerByIndex(_owner, i);
    }
    return tokenIds;
  }

  function tokenURI(uint256 tokenId)
    public
    view
    virtual
    override
    returns (string memory)
  {
    require(
      _exists(tokenId),
      "ERC721Metadata: URI query for nonexistent token"
    );

    string memory currentBaseURI = _baseURI();
    return bytes(currentBaseURI).length > 0
        ? string(abi.encodePacked(currentBaseURI, tokenId.toString(), baseExtension))
        : "";
  }

//   //only owner
//   function setCost(uint256 _newCost) public onlyOwner {
//     cost = _newCost;
//   }

//   function setmaxMintAmount(uint256 _newmaxMintAmount) public onlyOwner {
//     maxMintAmount = _newmaxMintAmount;
//   }

  function setBaseURI(string memory _newBaseURI) public {
    baseURI = _newBaseURI;
  }

//   function setBaseExtension(string memory _newBaseExtension) public onlyOwner {
//     baseExtension = _newBaseExtension;
//   }

//   function pause(bool _state) public onlyOwner {
//     paused = _state;
//   }
 
//  function whitelistUser(address _user) public onlyOwner {
//     whitelisted[_user] = true;
//   }
 
//   function removeWhitelistUser(address _user) public onlyOwner {
//     whitelisted[_user] = false;
//   }

//   function withdraw() public payable onlyOwner {    
//     // This will payout the owner 95% of the contract balance.
//     // Do not remove this otherwise you will not be able to withdraw the funds.
//     // =============================================================================
//     (bool os, ) = payable(owner()).call{value: address(this).balance}("");
//     require(os);
//     // =============================================================================
//   }
}