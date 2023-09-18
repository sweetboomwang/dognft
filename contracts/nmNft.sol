// contracts/MyNFT.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "hardhat/console.sol";


contract NuclearMutationNFT is ERC721,Ownable,Pausable {
    using Strings for uint256;
    string private baseUri_1;
    string private boxUri_1;
    string private baseUri_2;
    string private boxUri_2;
    string private baseUri_3;
    string private boxUri_3;
    string private baseUri_4;
    string private boxUri_4;
    string private baseUri_5;
    string private boxUri_5;
    string private baseUri_6;
    string private boxUri_6;
    string private baseUri_7;
    string private boxUri_7;
    string private baseUri_8;
    string private boxUri_8;
    uint256 public immutable offset;
    uint256 public constant seriesSize = 24;
    uint256 public constant totalSupply = 192;
    uint256 public price = 0.06 ether;

    uint256 public maxId;
    BoxStatus boxStatus;

    event ReceiveRecharge(address, uint256);
    event BatchMint(address, uint256);
    event AirDrop(address[]);


    struct BoxStatus{
        uint32 boxStatus_1;
        uint32 boxStatus_2;
        uint32 boxStatus_3;
        uint32 boxStatus_4;
        uint32 boxStatus_5;
        uint32 boxStatus_6;
        uint32 boxStatus_7;
        uint32 boxStatus_8;
    }

    constructor() ERC721("NuclearMutationNFT", "NMNFT") payable{
        offset = block.timestamp;
    }

    function batchMint(address to,uint64 num) whenNotPaused external payable{
        require(num<=5,"num can't be exceed 5");
        uint256 currentId = maxId;
        require(currentId + num <=totalSupply,"has been reached the limit");
        require(price * num <= msg.value,"insufficient value");
        
        for(uint8 i=0;i<num;i++){
            _safeMint(to, ++currentId);
        }
        maxId = currentId;
        emit BatchMint(to,num);
    }

    function airdrop(address[] calldata to) onlyOwner whenNotPaused external{
        uint256 currentId = maxId;
        require(currentId + to.length <=totalSupply,"has been reached the limit");

        for(uint8 i=0;i<to.length;i++){
            _safeMint(to[i],++currentId);
        }
        maxId = currentId;
        emit AirDrop(to);
    }

    function setURI_1(string calldata _boxUri, string calldata _baseUri) onlyOwner external {
        boxUri_1 = _boxUri;
        baseUri_1 = _baseUri;
    }

    function setURI_2(string calldata _boxUri, string calldata _baseUri) onlyOwner external {
        boxUri_2 = _boxUri;
        baseUri_2 = _baseUri;
    }

    function setURI_3(string calldata _boxUri, string calldata _baseUri) onlyOwner external {
        boxUri_3 = _boxUri;
        baseUri_3 = _baseUri;
    }

    function setURI_4(string calldata _boxUri, string calldata _baseUri) onlyOwner external {
        boxUri_4 = _boxUri;
        baseUri_4 = _baseUri;
    }

    function setURI_5(string calldata _boxUri, string calldata _baseUri) onlyOwner external {
        boxUri_5 = _boxUri;
        baseUri_5 = _baseUri;
    }

    function setURI_6(string calldata _boxUri, string calldata _baseUri) onlyOwner external {
        boxUri_6 = _boxUri;
        baseUri_6 = _baseUri;
    }

    function setURI_7(string calldata _boxUri, string calldata _baseUri) onlyOwner external {
        boxUri_7 = _boxUri;
        baseUri_7 = _baseUri;
    }

    function setURI_8(string calldata _boxUri, string calldata _baseUri) onlyOwner external {
        boxUri_8 = _boxUri;
        baseUri_8 = _baseUri;
    }

    function setPrice(uint256 _price) onlyOwner external{
        price = _price;
    }
    
    function getURI_1() onlyOwner external view returns(string memory boxUri,string memory baseUri){
        boxUri = boxUri_1;
        baseUri = baseUri_1;
    }

    function getURI_2() onlyOwner external view returns(string memory boxUri,string memory baseUri){
        boxUri = boxUri_2;
        baseUri = baseUri_2;
    }

    function getURI_3() onlyOwner external view returns(string memory boxUri,string memory baseUri){
        boxUri = boxUri_3;
        baseUri = baseUri_3;
    }

    function getURI_4() onlyOwner external view returns(string memory boxUri,string memory baseUri){
        boxUri = boxUri_4;
        baseUri = baseUri_4;
    }

    function getURI_5() onlyOwner external view returns(string memory boxUri,string memory baseUri){
        boxUri = boxUri_5;
        baseUri = baseUri_5;
    }

    function getURI_6() onlyOwner external view returns(string memory boxUri,string memory baseUri){
        boxUri = boxUri_6;
        baseUri = baseUri_6;
    }

    function getURI_7() onlyOwner external view returns(string memory boxUri,string memory baseUri){
        boxUri = boxUri_7;
        baseUri = baseUri_7;
    }

    function getURI_8() onlyOwner external view returns(string memory boxUri,string memory baseUri){
        boxUri = boxUri_8;
        baseUri = baseUri_8;
    }



   

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        _requireMinted(tokenId);

        uint256 seriesId = (tokenId-1) / seriesSize;

        string memory baseURI;
        string memory boxURI;
        BoxStatus memory bs = boxStatus;
        uint256 _boxStatus;

        if(seriesId == 0){
            baseURI = baseUri_1;
            boxURI = boxUri_1;
            _boxStatus = bs.boxStatus_1;
        }else if(seriesId == 1){
            baseURI = baseUri_2;
            boxURI = boxUri_2;
            _boxStatus = bs.boxStatus_2;
        }else if(seriesId == 2){
            baseURI = baseUri_3;
            boxURI = boxUri_3;
            _boxStatus = bs.boxStatus_3;
        }else if(seriesId == 3){
            baseURI = baseUri_4;
            boxURI = boxUri_4;
            _boxStatus = bs.boxStatus_4;
        }else if(seriesId == 4){
            baseURI = baseUri_5;
            boxURI = boxUri_5;
            _boxStatus = bs.boxStatus_5;
        }else if(seriesId == 5){
            baseURI = baseUri_6;
            boxURI = boxUri_6;
            _boxStatus = bs.boxStatus_6;
        }else if(seriesId == 6){
            baseURI = baseUri_7;
            boxURI = boxUri_7;
            _boxStatus = bs.boxStatus_7;
        }else if(seriesId == 7){
            baseURI = baseUri_8;
            boxURI = boxUri_8;
            _boxStatus = bs.boxStatus_8;
        }
        
        require(bytes(baseURI).length > 0,"baseURI not yet set");
        require(bytes(boxURI).length > 0,"boxURI not yet set");
       
        uint256 picId = (tokenId- 1 + offset) % seriesSize + 1;
        return _boxStatus == 1 ? string(abi.encodePacked(baseURI, picId.toString())) : boxURI;
    }


    function openBox(uint256 _seriesNum) onlyOwner external{
       changeBoxStatus(_seriesNum,1);
    }

    function closeBox(uint256 _seriesNum) onlyOwner external{
       changeBoxStatus(_seriesNum,0);
    }

    function changeBoxStatus(uint256 _seriesNum,uint32 _status) onlyOwner internal{
        BoxStatus memory bs = boxStatus;
        if(_seriesNum == 1){
            bs.boxStatus_1 = _status;
        }else if(_seriesNum == 2){
            bs.boxStatus_2 = _status;
        }else if(_seriesNum == 3){
            bs.boxStatus_3 = _status;
        }else if(_seriesNum == 4){
            bs.boxStatus_4 = _status;
        }else if(_seriesNum == 5){
            bs.boxStatus_5 = _status;
        }else if(_seriesNum == 6){
            bs.boxStatus_6 = _status;
        }else if(_seriesNum == 7){
            bs.boxStatus_7 = _status;
        }else if(_seriesNum == 8){
            bs.boxStatus_8 = _status;
        }
        boxStatus = bs;
    }

    function withdraw() onlyOwner external{
        payable(msg.sender).transfer(address(this).balance);
    }

    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }

    receive() external payable {
        emit ReceiveRecharge(msg.sender, msg.value);
    }



    
}