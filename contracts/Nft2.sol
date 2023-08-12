// contracts/MyNFT.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";


contract DogNft is ERC721,Ownable {
    using Strings for uint256;
    string private baseUri;
    string private boxUri;
    uint256 public immutable offset;
    uint256 public boxStatus;
    NftInfo info;

    struct NftInfo{
        uint64 totalSupply;
        uint64 maxId;
    }

    constructor(uint64 _totalSupply,string memory _baseUri,string memory _boxUri) ERC721("DogNft", "Dog") payable{
        info.totalSupply = _totalSupply;
        offset = block.timestamp;
        baseUri = _baseUri;
        boxUri = _boxUri;
    }

    function batchMint(address to,uint64 num) external payable{
        require(num<=2,"num can't be exceed 10");
        NftInfo memory n = info;
        require(n.maxId + num <=n.totalSupply,"has been reached the limit");
        
        uint64 currentId = n.maxId;
        for(uint8 i=0;i<num;i++){
            _safeMint(to, ++currentId);
        }
        info.maxId = currentId;
    }

    function airdrop(address[] calldata to) onlyOwner external{
        NftInfo memory n = info;
        uint64 currentId = n.maxId;
        require(currentId + to.length <=n.totalSupply,"has been reached the limit");

        for(uint8 i=0;i<to.length;i++){
            _safeMint(to[i],++currentId);
        }
        info.maxId = currentId;
    }

    function setBaseURI(string calldata uri) onlyOwner external {
        baseUri = uri;
    }
    
    function setBoxURI(string calldata uri) onlyOwner external {
        boxUri = uri;
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        _requireMinted(tokenId);
        
        string memory baseURI = baseUri;
        require(bytes(baseURI).length > 0,"baseURI not yet set");

        string memory boxURI = boxUri;
        require(bytes(boxURI).length > 0,"boxURI not yet set");

        NftInfo memory i = info;
        uint256 realId = (tokenId + offset) % i.totalSupply + 1;
        return boxStatus == 1 ? string(abi.encodePacked(baseURI, realId.toString())) : boxURI;
    }

    function openBox() onlyOwner external{
        boxStatus = 1;
    }

    function totalSupply() view public returns(uint256){
        return info.totalSupply;
    }

    function withdraw() onlyOwner external{
        payable(msg.sender).transfer(address(this).balance);
    }



    
}