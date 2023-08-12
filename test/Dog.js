const {
    time,
    loadFixture,
  } = require("@nomicfoundation/hardhat-toolbox/network-helpers");
  const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
  const { expect } = require("chai");

  describe("Dog", function () {

    async function deployFixture() {
       
        const ONE_GWEI = 1_000_000_000;
        const lockedAmount = ONE_GWEI;
        const [owner, otherAccount] = await ethers.getSigners();
    
        const DogNft = await ethers.getContractFactory("DogNft");
        const dog = await DogNft.deploy({ value: lockedAmount });
    
        return { dog,owner };
      }

      describe("Mint", function () {
        // describe("Validations", function () {
        //   it("Should revert with the right error if called too soon", async function () {
        //     const { dog,owner } = await loadFixture(deployFixture);
        //     console.log("owner:",owner.address);
        //     await expect(dog.mint()).not.to.be.reverted
        //   });
        // })

        describe("TokenIncrement", function () {
            it("Should revert with the right error if called too soon", async function () {
              const { dog,owner } = await loadFixture(deployFixture);
              console.log("owner:",owner.address);
              await dog.mint(owner.address);
              const totalSupply = await dog._totalSupply();
              console.log("totalSupply:",totalSupply);
              await expect(String(totalSupply)).to.equal("1");
            });
          })


        describe("BaseURI", function () {
            it("not minted valid right", async function () {
              const { dog,owner } = await loadFixture(deployFixture);
              await expect(dog.tokenURI(2)).to.be.revertedWith("ERC721: invalid token ID");
            });

            it("after minted valid right", async function () {
                const { dog,owner } = await loadFixture(deployFixture);
  
                await dog.mint(owner.address);
                await expect(dog.tokenURI(1)).to.be.revertedWith("baseURI not yet set");
            });

            it("baseURI set right", async function () {
                const { dog,owner } = await loadFixture(deployFixture);
  
                await dog.mint(owner.address);
                await dog.setBaseURI("www.baidu.com");
                await expect(await dog.tokenURI(1)).to.equal("www.baidu.com");
  
                // const uri1 = await dog.tokenURI(1)
                // console.log("box not open uri:",uri1);
  
                // await expect(await dog.openBox()).not.to.be.rejected;
                // const uri2 = await dog.tokenURI(1)
                // console.log("box open uri:",uri2);
            });
          })

        describe("AirDrop", function () {
            it("air drop right", async function () {
              const { dog,owner } = await loadFixture(deployFixture);
              const wallets = new Array();
              wallets.push("0xb56bdaFeaB6bCA60a74630d4a24eC6EaE8e56D6D");
              wallets.push("0x072056252Bf49E462cCF03fd13833Ec126f5edf6");
              await expect(dog.airdrop(wallets)).not.to.be.reverted;
            });
            it("check air drop owner right", async function () {
                const { dog,owner } = await loadFixture(deployFixture);
                const wallets = new Array();
                wallets.push("0xb56bdaFeaB6bCA60a74630d4a24eC6EaE8e56D6D");
                wallets.push("0x072056252Bf49E462cCF03fd13833Ec126f5edf6");
                await dog.airdrop(wallets);
                await expect(await dog.ownerOf(1)).to.equal("0xb56bdaFeaB6bCA60a74630d4a24eC6EaE8e56D6D");
              });
            
        })

        
    })
    
  })