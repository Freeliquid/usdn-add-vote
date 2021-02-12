// SPDX-License-Identifier: GPL-3.0-or-later
// Copyright (C) 2020 Maker Ecosystem Growth Holdings, INC.
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

pragma solidity 0.6.7;


import "./IERC20.sol";


interface PauseLike {
    function delay() external returns (uint);
    function exec(address, bytes32, bytes calldata, uint256) external;
    function plot(address, bytes32, bytes calldata, uint256) external;
}

interface IlkRegistryAbstract {
    function wards(address) external view returns (uint256);
    function rely(address) external;
    function deny(address) external;
    function vat() external view returns (address);
    function cat() external view returns (address);
    function spot() external view returns (address);
    function add(address) external;
}

interface ChainlogAbstract {
    function wards(address) external view returns (uint256);
    function rely(address) external;
    function deny(address) external;
    function keys() external view returns (bytes32[] memory);
    function version() external view returns (string memory);
    function ipfs() external view returns (string memory);
    function setVersion(string calldata) external;
    function setSha256sum(string calldata) external;
    function setIPFS(string calldata) external;
    function setAddress(bytes32,address) external;
    function removeAddress(bytes32) external;
    function count() external view returns (uint256);
    function get(uint256) external view returns (bytes32,address);
    function list() external view returns (bytes32[] memory);
    function getAddress(bytes32) external view returns (address);
}

interface GemJoinAbstract {
    function wards(address) external view returns (uint256);
    function rely(address) external;
    function deny(address) external;
    function vat() external view returns (address);
    function ilk() external view returns (bytes32);
    function gem() external view returns (address);
    function dec() external view returns (uint256);
    function live() external view returns (uint256);
    function cage() external;
    function join(address, uint256) external;
    function exit(address, uint256) external;
}

interface FlipAbstract {
    function wards(address) external view returns (uint256);
    function rely(address usr) external;
    function deny(address usr) external;
    function bids(uint256) external view returns (uint256, uint256, address, uint48, uint48, address, address, uint256);
    function vat() external view returns (address);
    function cat() external view returns (address);
    function ilk() external view returns (bytes32);
    function beg() external view returns (uint256);
    function ttl() external view returns (uint48);
    function tau() external view returns (uint48);
    function kicks() external view returns (uint256);
    function file(bytes32, uint256) external;
    function kick(address, address, uint256, uint256, uint256) external returns (uint256);
    function tick(uint256) external;
    function tend(uint256, uint256, uint256) external;
    function dent(uint256, uint256, uint256) external;
    function deal(uint256) external;
    function yank(uint256) external;
}

interface OsmMomAbstract {
    function owner() external view returns (address);
    function authority() external view returns (address);
    function osms(bytes32) external view returns (address);
    function setOsm(bytes32, address) external;
    function setOwner(address) external;
    function setAuthority(address) external;
    function stop(bytes32) external;
}

interface VatAbstract {
    function wards(address) external view returns (uint256);
    function rely(address) external;
    function deny(address) external;
    function urns(bytes32, address) external view returns (uint256, uint256);
    function gem(bytes32, address) external view returns (uint256);
    function dai(address) external view returns (uint256);
    function vice() external view returns (uint256);
    function Line() external view returns (uint256);
    function live() external view returns (uint256);
    function init(bytes32) external;
    function file(bytes32, uint256) external;
    function file(bytes32, bytes32, uint256) external;
}


interface ConfigLike {
    function init(bytes32) external;
    function file(bytes32, bytes32, address) external;
    function file(bytes32, bytes32, uint) external;
    function rely(address) external;
}


interface SpotAbstract {
    function wards(address) external view returns (uint256);
    function rely(address) external;
    function deny(address) external;
    function ilks(bytes32) external view returns (address, uint256);
    function vat() external view returns (address);
    function par() external view returns (uint256);
    function live() external view returns (uint256);
    function file(bytes32, bytes32, address) external;
    function file(bytes32, uint256) external;
    function file(bytes32, bytes32, uint256) external;
    function poke(bytes32) external;
    function cage() external;
}

library SharedStructs {

    // decimals & precision
    uint256 constant THOUSAND = 10 ** 3;
    uint256 constant MILLION  = 10 ** 6;
    uint256 constant WAD      = 10 ** 18;
    uint256 constant RAY      = 10 ** 27;
    uint256 constant RAD      = 10 ** 45;

    uint256 constant ZERO_PERCENT_RATE            = 1000000000000000000000000000;


    struct IlkNetSpecific {   
        address gem;
        address join;
        address flip;
        address pip;
        ChainlogAbstract CHANGELOG;
    }

    struct IlkDesc {   
        bytes32 ilk;
        bytes32 joinName;
        bytes32 flipName;
        bytes32 pipName;
        bytes32 gemName;
        uint256 line;
        uint256 dust;
        uint256 dunk;
        uint256 chop;
        uint256 duty;
        uint256 beg;
        uint256 ttl;
        uint256 tau;
        uint256 mat;
    }
}

contract SpellAction {


    // Many of the settings that change weekly rely on the rate accumulator
    // described at https://docs.makerdao.com/smart-contract-modules/rates-module
    // To check this yourself, use the following rate calculation (example 8%):
    //
    // $ bc -l <<< 'scale=27; e( l(1.08)/(60 * 60 * 24 * 365) )'
    //
    // A table of rates can be found at
    //    https://ipfs.io/ipfs/QmefQMseb3AiTapiAKKexdKHig8wroKuZbmLtPLv4u2YwW
    //
    uint256 constant ZERO_PERCENT_RATE            = 1000000000000000000000000000;
    uint256 constant ONE_PERCENT_RATE             = 1000000000315522921573372069;
    uint256 constant TWO_PERCENT_RATE             = 1000000000627937192491029810;
    uint256 constant TWO_POINT_FIVE_PERCENT_RATE  = 1000000000782997609082909351;
    uint256 constant THREE_PERCENT_RATE           = 1000000000937303470807876289;
    uint256 constant FOUR_POINT_FIVE_PERCENT_RATE = 1000000001395766281313196627;
    uint256 constant FIVE_PERCENT_RATE            = 1000000001547125957863212448;
    uint256 constant SIX_PERCENT_RATE             = 1000000001847694957439350562;
    uint256 constant EIGHT_PERCENT_RATE           = 1000000002440418608258400030;
    uint256 constant NINE_PERCENT_RATE            = 1000000002732676825177582095;
    uint256 constant TEN_PERCENT_RATE             = 1000000003022265980097387650;



    function execute(SharedStructs.IlkDesc memory desc, 
                     SharedStructs.IlkNetSpecific memory net) internal {

        ChainlogAbstract CHANGELOG = net.CHANGELOG;

        address MCD_VAT      = CHANGELOG.getAddress("MCD_VAT");
        address MCD_CAT      = CHANGELOG.getAddress("MCD_CAT");
        address MCD_JUG      = CHANGELOG.getAddress("MCD_JUG");
        address MCD_SPOT     = CHANGELOG.getAddress("MCD_SPOT");
        address MCD_END      = CHANGELOG.getAddress("MCD_END");
        address FLIPPER_MOM  = CHANGELOG.getAddress("FLIPPER_MOM");
        address OSM_MOM      = CHANGELOG.getAddress("OSM_MOM"); // Only if PIP_TOKEN = Osm
        address ILK_REGISTRY = CHANGELOG.getAddress("ILK_REGISTRY");


        // Set the global debt ceiling
        // +  100 M for gem-A
        VatAbstract(MCD_VAT).file("Line", VatAbstract(MCD_VAT).Line() + desc.line * SharedStructs.MILLION * SharedStructs.RAD);

        // Sanity checks
        require(GemJoinAbstract(net.join).vat() == MCD_VAT, "join-vat-not-match");
        require(GemJoinAbstract(net.join).ilk() == desc.ilk, "join-ilk-not-match");
        require(GemJoinAbstract(net.join).gem() == net.gem, "join-gem-not-match");
        require(GemJoinAbstract(net.join).dec() == IERC20(net.gem).decimals(), "join-dec-not-match");
        require(FlipAbstract(net.flip).vat() == MCD_VAT, "flip-vat-not-match");
        require(FlipAbstract(net.flip).cat() == MCD_CAT, "flip-cat-not-match");
        require(FlipAbstract(net.flip).ilk() == desc.ilk, "flip-ilk-not-match");

        // Set the gem PIP in the Spotter
        SpotAbstract(MCD_SPOT).file(desc.ilk, "pip", net.pip);

        // Set the gem-A Flipper in the Cat
        ConfigLike(MCD_CAT).file(desc.ilk, "flip", net.flip);

        // Init gem-A ilk in Vat & Jug
        VatAbstract(MCD_VAT).init(desc.ilk);
        ConfigLike(MCD_JUG).init(desc.ilk);

        // Allow gem-A Join to modify Vat registry
        VatAbstract(MCD_VAT).rely(net.join);
        // Allow the gem-A Flipper to reduce the Cat litterbox on deal()
        ConfigLike(MCD_CAT).rely(net.flip);
        // Allow Cat to kick auctions in gem-A Flipper
        FlipAbstract(net.flip).rely(MCD_CAT);
        // Allow End to yank auctions in gem-A Flipper
        FlipAbstract(net.flip).rely(MCD_END);
        // Allow FlipperMom to access to the gem-A Flipper
        FlipAbstract(net.flip).rely(FLIPPER_MOM);
        // Disallow Cat to kick auctions in gem-A Flipper
        // !!!!!!!! Only for certain collaterals that do not trigger liquidations like USDC-A)
        //FlipperMomAbstract(FLIPPER_MOM).deny(net.flip);

        // Set gem Osm in the OsmMom for new ilk
        // !!!!!!!! Only if net.pip = Osm
        OsmMomAbstract(OSM_MOM).setOsm(desc.ilk, net.pip);

        // Set the gem-A debt ceiling
        VatAbstract(MCD_VAT).file(desc.ilk, "line", desc.line * SharedStructs.MILLION * SharedStructs.RAD);
        // Set the gem-A dust
        VatAbstract(MCD_VAT).file(desc.ilk, "dust", desc.dust * SharedStructs.RAD);
        // Set the Lot size
        ConfigLike(MCD_CAT).file(desc.ilk, "dunk", desc.dunk * SharedStructs.RAD);
        // Set the gem-A liquidation penalty (e.g. 13% => X = 113)
        ConfigLike(MCD_CAT).file(desc.ilk, "chop", desc.chop);
        // Set the gem-A stability fee (e.g. 1% = 1000000000315522921573372069)
        ConfigLike(MCD_JUG).file(desc.ilk, "duty", desc.duty);
        // Set the gem-A percentage between bids (e.g. 3% => X = 103)
        FlipAbstract(net.flip).file("beg", desc.beg);
        // Set the gem-A time max time between bids
        FlipAbstract(net.flip).file("ttl", desc.ttl);
        // Set the gem-A max auction duration to
        FlipAbstract(net.flip).file("tau", desc.tau);
        // Set the gem-A min collateralization ratio (e.g. 150% => X = 150)
        SpotAbstract(MCD_SPOT).file(desc.ilk, "mat", desc.mat);

        // Update gem-A spot value in Vat
        SpotAbstract(MCD_SPOT).poke(desc.ilk);

        // Add new ilk to the IlkRegistry
        IlkRegistryAbstract(ILK_REGISTRY).add(net.join);

        // Update the changelog
        CHANGELOG.setAddress(desc.gemName, net.gem);
        CHANGELOG.setAddress(desc.joinName, net.join);
        CHANGELOG.setAddress(desc.flipName, net.flip);
        CHANGELOG.setAddress(desc.pipName, net.pip);
        // Bump version

    }
}


contract IlkCfgUSDNUSDC {

    function getIlkCfgUSDNUSDC() internal pure returns (SharedStructs.IlkDesc memory desc) {

        desc.ilk = "USDNUSDC-A";
        desc.joinName = "MCD_JOIN_USDNUSDC_A";
        desc.flipName = "MCD_FLIP_USDNUSDC_A";
        desc.pipName = "PIP_USDNUSDC";
        desc.gemName = "USDNUSDC";
        desc.line = 150;
        desc.dust = 100;
        desc.dunk = 50000;
        desc.chop = 113 * SharedStructs.WAD / 100;
        desc.duty = SharedStructs.ZERO_PERCENT_RATE;
        desc.beg = 101 * SharedStructs.WAD / 100;
        desc.ttl = 21600;
        desc.tau = 21600;
        desc.mat = 110 * SharedStructs.RAY / 100;
    }
}

contract IlkCfgUSDNDAI {

    function getIlkCfgUSDNDAI() internal pure returns (SharedStructs.IlkDesc memory desc) {

        desc.ilk = "USDNDAI-A";
        desc.joinName = "MCD_JOIN_USDNDAI_A";
        desc.flipName = "MCD_FLIP_USDNDAI_A";
        desc.pipName = "PIP_USDNDAI";
        desc.gemName = "USDNDAI";
        desc.line = 150;
        desc.dust = 100;
        desc.dunk = 50000;
        desc.chop = 113 * SharedStructs.WAD / 100;
        desc.duty = SharedStructs.ZERO_PERCENT_RATE;
        desc.beg = 101 * SharedStructs.WAD / 100;
        desc.ttl = 21600;
        desc.tau = 21600;
        desc.mat = 110 * SharedStructs.RAY / 100;
    }
}

contract SpellActionCommon is SpellAction {

    function executeCommon(address changeLogAddr,
                           SharedStructs.IlkNetSpecific memory netUSDNDAI,
                           SharedStructs.IlkNetSpecific memory netUSDNUSDC,
                           SharedStructs.IlkDesc memory descUSDNDAI,
                           SharedStructs.IlkDesc memory descUSDNUSDC) internal {

        netUSDNUSDC.CHANGELOG = ChainlogAbstract(changeLogAddr);
        netUSDNDAI.CHANGELOG = ChainlogAbstract(changeLogAddr);

        execute(descUSDNDAI, netUSDNDAI);
        execute(descUSDNUSDC, netUSDNUSDC);

        address MCD_VAT = ChainlogAbstract(changeLogAddr).getAddress("MCD_VAT");

        VatAbstract(MCD_VAT).file(bytes32("USDTUSDC-A"), "line", 0);
        VatAbstract(MCD_VAT).file(bytes32("USDTDAI-A"), "line", 0);
        VatAbstract(MCD_VAT).file(bytes32("USDTUSDN-A"), "line", 0);

        ChainlogAbstract(changeLogAddr).setVersion("1.1.0");
    }
}

contract SpellActionMainnet is SpellActionCommon, IlkCfgUSDNDAI, IlkCfgUSDNUSDC {
    function execute() external {

        SharedStructs.IlkNetSpecific memory netUSDNDAI;
        SharedStructs.IlkNetSpecific memory netUSDNUSDC;

        netUSDNDAI.gem  = 0x0000000000000000000000000000000000000000;
        netUSDNDAI.join = 0x0000000000000000000000000000000000000000;
        netUSDNDAI.flip = 0x0000000000000000000000000000000000000000;
        netUSDNDAI.pip = 0x0000000000000000000000000000000000000000;

        netUSDNUSDC.gem  = 0x0000000000000000000000000000000000000000;
        netUSDNUSDC.join = 0x0000000000000000000000000000000000000000;
        netUSDNUSDC.flip = 0x0000000000000000000000000000000000000000;
        netUSDNUSDC.pip = 0x0000000000000000000000000000000000000000;

        executeCommon(0x0000000000000000000000000000000000000000,
                      netUSDNDAI, netUSDNUSDC, getIlkCfgUSDNDAI(), getIlkCfgUSDNUSDC());
    }
}



contract SpellActionKovan is SpellActionCommon, IlkCfgUSDNDAI, IlkCfgUSDNUSDC {
    function execute() external {

        SharedStructs.IlkNetSpecific memory netUSDNDAI;
        SharedStructs.IlkNetSpecific memory netUSDNUSDC;

        netUSDNDAI.gem  = 0xA778bc72bF31953555b6E094503792BA66cc8d72;
        netUSDNDAI.join = 0x79C405269c25764b836B820dE2d9A192232E3579;
        netUSDNDAI.flip = 0x6A3d699AE0357e1003c95fEa5BF3Ef29cB2bf211;
        netUSDNDAI.pip = 0xa19d59e6a7440015B52fB3FcB44C9D3D33099b11;

        netUSDNUSDC.gem  = 0x30DaBEd27aF8Bdeec71D8b0CeEa0f6C954E1E060;
        netUSDNUSDC.join = 0x72ad2d668de04A3fbEa7209053804147C767F4C3;
        netUSDNUSDC.flip = 0x653DedfFd1e7186A2068F6686DB362b8D7F2d2c9;
        netUSDNUSDC.pip = 0x00fDF2C917CA0d938b2eE0E3C2975a1B7bfBDCd2;

        executeCommon(0x82D62e8B5355f0dc2DA894D18EFCce349C2dE71C,
                      netUSDNDAI, netUSDNUSDC, getIlkCfgUSDNDAI(), getIlkCfgUSDNUSDC());
    }
}



contract ActionSpell {
    bool      public done;
    address   public pause;
    uint256   public expiration;


    address   public action;
    bytes32   public tag;
    uint256   public eta;
    bytes     public sig;




    function setup(address deployer) internal {
        expiration = block.timestamp + 30 days;
        sig = abi.encodeWithSignature("execute()");
        bytes32 _tag; assembly { _tag := extcodehash(deployer) }
        action = deployer;
        tag = _tag;
    }

    function schedule() external {
        require(block.timestamp <= expiration, "DSSSpell/spell-has-expired");
        require(eta == 0, "spell-already-scheduled");
        eta = now + PauseLike(pause).delay();
        PauseLike(pause).plot(action, tag, sig, eta);
    }

    function cast() public {
        require(!done, "spell-already-cast");
        done = true;
        PauseLike(pause).exec(action, tag, sig, eta);
    }
}


contract ActionSpellMainnet is ActionSpell {
    constructor() public {
        pause = 0x146921eF7A94C50b96cb53Eb9C2CA4EB25D4Bfa8;
        setup(address(new SpellActionMainnet()));
    }
}


contract ActionSpellKovan is ActionSpell {
    constructor() public {
        pause = 0x4608754e7Ca3caCD54b6C4862C978214243AB3da;
        setup(address(new SpellActionKovan()));
    }
}
