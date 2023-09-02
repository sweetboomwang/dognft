// contracts/MyNFT.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";


contract WeepingNft is ERC721,Ownable {
    using Strings for uint256;
    string private baseUri;
    uint64 private tokenId;

    constructor(string memory _baseUri) ERC721("WeepingNft", "WNft") {
        baseUri = _baseUri;
    }

    function airdrop(address[] calldata to) onlyOwner external{
        uint64 currentId = tokenId;
        for(uint8 i=0;i<to.length;i++){
            _safeMint(to[i],++currentId);
            _safeMint(to[i],++currentId);
        }
        tokenId = currentId;
    }

    function setBaseURI(string calldata uri) onlyOwner external {
        baseUri = uri;
    }

    function tokenURI(uint256 _tokenId) public view virtual override returns (string memory) {
        _requireMinted(_tokenId);
        
        string memory baseURI = baseUri;
        require(bytes(baseURI).length > 0,"baseURI not yet set");
        uint256 realId = _tokenId % 2 +1;
        return string(abi.encodePacked(baseURI, realId.toString(),".json")) ;
    }

    function totalSupply() view public returns(uint256){
        return tokenId;
    }

    function withdraw() onlyOwner external{
        payable(msg.sender).transfer(address(this).balance);
    }


    
}