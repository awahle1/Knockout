pragma solidity >=0.4.22 <0.9.0;

contract Knockout {

    struct Package {
        string name;
        string show;
        string link;
        uint256 price;
    }

    Package[] public packages;

    mapping(string => Package) public nameToPackage;

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function addPackage(string memory name, string memory show, string memory link, uint256 price) public ownerOnly {
        Package memory newPackage = Package(name, show, link, price);
        packages.push(newPackage);
        nameToPackage[name] = newPackage;
    }

    function buy(uint256 pkgIndex) public payable returns(string memory) {
        Package memory pkg = packages[pkgIndex];
        require(msg.value>pkg.price);
        string memory name = pkg.name;
        string memory link = pkg.link;
        //Issue nft to msg.sender

        packages[pkgIndex] = packages[packages.length-1];
        packages.pop();
        return("Purchased");
    }

    function getPackages() public view returns(Package[] memory){
        return(packages);
    }

    modifier ownerOnly(){
        require(msg.sender==owner);
        _;
    }


}
