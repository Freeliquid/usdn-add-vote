pragma solidity 0.6.7;


interface ChainlogAbstract {
    function setAddress(bytes32,address) external;
    function setVersion(string calldata) external;
}


contract SetupChainlog {
    bool public activated;
    address public owner;

    constructor() public {
        owner = msg.sender;
    }

    function setup(address addr) public {
        require(owner == msg.sender, "auth-error");

        require(!activated, "already-activated");
        activated = true;

        ChainlogAbstract CHANGELOG = ChainlogAbstract(addr);

        CHANGELOG.setAddress("DEPLOYER", 0xaaCE3a65C179667f53B01fB3F28Db10a0dce9629);
        CHANGELOG.setAddress("MULTICALL", 0xBC9F00a01705f37183E110fcf4622B84Ef00deA9);
        CHANGELOG.setAddress("FAUCET", 0x198958a51335C23Fbb82bd87c7a397FE8c96fAD6);
        CHANGELOG.setAddress("MCD_DEPLOY", 0x3a3C4427F9e54FC6eba965f6146Cf9Ff8d31795F);
        CHANGELOG.setAddress("MCD_GOV", 0x64F34b665966f02e74F8BE922c12f9ac4661c9A0);
        CHANGELOG.setAddress("GOV_GUARD", 0x0d0b907462904AEe73c4034aD9C8ec43a3224aB9);
        CHANGELOG.setAddress("MCD_IOU", 0x4f8467d4B2D089A55BD8eE5fB3512F380825ca98);
        CHANGELOG.setAddress("MCD_ADM", 0x3164cC6DBCf88E3ABe9836d595c2878d8c387601);
        CHANGELOG.setAddress("VOTE_PROXY_FACTORY", 0x59157e760cB0b5Fdf419EE84274D46641f8227eC);
        CHANGELOG.setAddress("MCD_VAT", 0xb6cBc309C5D8c04555Fea9D6Fbeb65E22A1d687e);
        CHANGELOG.setAddress("MCD_JUG", 0x17d615e1f9260c489b54468D77146A48eaB1C100);
        CHANGELOG.setAddress("MCD_CAT", 0x762cC32aD74AaFd358d096e99d6F5BC78A7cEf91);
        CHANGELOG.setAddress("MCD_VOW", 0x1ca208D892BfA40DEcEd354f09BfD7f2cFBEf52b);
        CHANGELOG.setAddress("MCD_JOIN_DAI", 0xaB0Aa36545125aDA4272CD6e5294EacdB6Cbfe6a);
        CHANGELOG.setAddress("MCD_JOIN_USDFL", 0xaB0Aa36545125aDA4272CD6e5294EacdB6Cbfe6a);
        CHANGELOG.setAddress("MCD_FLAP", 0x097638c8d5Bd30dE8eA95868b72aE7D8789E77e3);
        CHANGELOG.setAddress("MCD_FLOP", 0x00558d0DD268fd1372D46932577527D9BD73Bc5c);
        CHANGELOG.setAddress("MCD_PAUSE", 0x8dCDa003fF12Bd3546F5Faed6bb1413E506e019F);
        CHANGELOG.setAddress("MCD_PAUSE_PROXY", 0xB0002295B253fcC35856B9c063D94Cd5d584b313);
        CHANGELOG.setAddress("MCD_GOV_ACTIONS", 0xb5bFe46DD731F8482D4382621C7428c6C3F6AeED);
        CHANGELOG.setAddress("MCD_DAI", 0xe1a3c9d45589D34070b764E332fB0285Ead84FB0);
        CHANGELOG.setAddress("MCD_USDFL", 0xe1a3c9d45589D34070b764E332fB0285Ead84FB0);
        CHANGELOG.setAddress("MCD_SPOT", 0x07Dc457D1D102e954dd901251561E21ad19d61E8);
        CHANGELOG.setAddress("MCD_POT", 0x49aaC9E87D997b1bE62d3c57295F20F1436F82Dd);
        CHANGELOG.setAddress("MCD_END", 0x20737b2D24F3B0ef5dcbfDF70Ff1a412E1EA3b79);
        CHANGELOG.setAddress("MCD_ESM", 0xb54cf204C88bB82B6DBdF66226BB58e06cFa909b);
        CHANGELOG.setAddress("PROXY_ACTIONS", 0x9Cd2088C08F67fEb93Cbd1E66FE77be99487D712);
        CHANGELOG.setAddress("PROXY_ACTIONS_END", 0x9355E365fC14cc411597F5D59c4913938b8a475B);
        CHANGELOG.setAddress("PROXY_ACTIONS_DSR", 0x28bB7FaDe0Cd7f3C519bE103B5D130c301BD4A8c);
        CHANGELOG.setAddress("PROXY_ACTIONS_REWARD", 0x44ae7E2546E9f91427F7197deDA1bAed12a3d3dC);
        CHANGELOG.setAddress("PROXY_PAUSE_ACTIONS_ADD", 0x2EaB7b218235d11ea56060FA017Ea8611e9D71A5);
        CHANGELOG.setAddress("FL_REWARDER", 0xc3Fa8D75Ec3cb35f6cb7D640FcF1F0318f2cF9d7);
        CHANGELOG.setAddress("FL_REWARDER_GOV_USD", 0x9E02C8a95A9123A389ea7872648e2900C1d5502a);
        CHANGELOG.setAddress("FL_REWARDER_STABLES", 0x5B6e8d91CaA6dA17c5927C82d43Aaf6e966C6279);
        CHANGELOG.setAddress("FL_REWARDER_GOV_USD_HOLDER", 0xf7bB36180ac01dc5D77bc2CAd925b128797689cB);
        CHANGELOG.setAddress("FL_REWARDER_STABLES_HOLDER", 0x60FE1Ab5A35E0f626a5FaBb20bAaDf96E6cbB4Bc);
        CHANGELOG.setAddress("FL_REWARD_AGGREGATOR", 0x7C402b08a6ab7D9e4787C68ab90c323A4F629Fe0);
        CHANGELOG.setAddress("FL_REWARD_MAIN_CHECKER_CONTRACT", 0x48CF12dBb3b348972DD0dceE2397efEAF813b2e4);
        CHANGELOG.setAddress("FL_REWARD_CHECKER_CONTRACT", 0x5cB0b01d8844c5D65BD35B30C186265b2D6D0168);
        CHANGELOG.setAddress("FL_REWARD_PRICE_PROVIDER", 0xEf20d386419B428B2a2c787c8143EA1E28f48761);
        CHANGELOG.setAddress("FL_UNI_ADAPTER_STABLES", 0x6D9fcEb21B7664c3D264c5961aB5bd565A2Eb746);
        CHANGELOG.setAddress("FL_UNI_ADAPTER_ONE_STABLE", 0x9A0c7eb5f0f6e76db695Eb49716F4957445B97Eb);
        CHANGELOG.setAddress("CDP_MANAGER", 0x73cc554C88B2076eB660CD577C7a84f27aB4a556);
        CHANGELOG.setAddress("DSR_MANAGER", 0x236a3b92183887Df685089724F9f1BF2669FF8f8);
        CHANGELOG.setAddress("GET_CDPS", 0x4a6B9ed7cD1Ac17769228bc76F567022e3a9EBC6);
        CHANGELOG.setAddress("ILK_REGISTRY", 0x896da2Fcf9E8F13DB16D198a2bf0F91d4d8B53f8);
        CHANGELOG.setAddress("OSM_MOM", 0xB1af07c4291B1E1266E470ddcb1880c779F25B35);
        CHANGELOG.setAddress("FLIPPER_MOM", 0xdD9E6C595d9996f58d0b9bE81F2A72EAd461152F);
        CHANGELOG.setAddress("PROXY_FACTORY", 0x9E6c491d265A0d75C5B6D9491b8BC0D82297DC54);
        CHANGELOG.setAddress("PROXY_REGISTRY", 0xF24E1a79a56Db7D363691332548bF365dB66b245);
        CHANGELOG.setAddress("USDCDAI", 0xd4d9A707C2943f59525a9de00D2967A99f8B5f0a);
        CHANGELOG.setAddress("VAL_USDCDAI", 0xADe6B497bD08453bb5264839c5163262F91F8e95);
        CHANGELOG.setAddress("PIP_USDCDAI", 0xADe6B497bD08453bb5264839c5163262F91F8e95);
        CHANGELOG.setAddress("MCD_JOIN_USDCDAI_A", 0xdEF046b2B509D4bF8947151e38d5E6600ad50f6f);
        CHANGELOG.setAddress("MCD_FLIP_USDCDAI_A", 0x334CD9bf95a249d596586dE4489762047D349c85);
        CHANGELOG.setAddress("USDTDAI", 0xF929aeD53652b76a4aD3B3F11102AEC5Dad6A918);
        CHANGELOG.setAddress("VAL_USDTDAI", 0x73267345EE58BF7896389FD9B87308FAb31071F9);
        CHANGELOG.setAddress("PIP_USDTDAI", 0x73267345EE58BF7896389FD9B87308FAb31071F9);
        CHANGELOG.setAddress("MCD_JOIN_USDTDAI_A", 0xc06563cD7b84408217234a1C0E5748fc45118DCb);
        CHANGELOG.setAddress("MCD_FLIP_USDTDAI_A", 0x64e4ed0c0B6ad56F272225643460B36E4728C262);
        CHANGELOG.setAddress("USDTUSDC", 0xEeA18D0ecd0391F96b129fAefdb51883FC4dBc18);
        CHANGELOG.setAddress("VAL_USDTUSDC", 0xeBdeE6A926F843FCfB37E6786AAe4D9af8e76b75);
        CHANGELOG.setAddress("PIP_USDTUSDC", 0xeBdeE6A926F843FCfB37E6786AAe4D9af8e76b75);
        CHANGELOG.setAddress("MCD_JOIN_USDTUSDC_A", 0x026cFA585d657e80ef55ae83cDe70f76322d6A27);
        CHANGELOG.setAddress("MCD_FLIP_USDTUSDC_A", 0xD7B67210d48896CD9887d1fCeE21a4DB4Ae61945);
        CHANGELOG.setAddress("USDNDAI", 0xA778bc72bF31953555b6E094503792BA66cc8d72);
        CHANGELOG.setAddress("VAL_USDNDAI", 0x6D9C64bb59E90895AEd8CDfdc39509B6cdA226f1);
        CHANGELOG.setAddress("PIP_USDNDAI", 0x6D9C64bb59E90895AEd8CDfdc39509B6cdA226f1);
        CHANGELOG.setAddress("MCD_JOIN_USDNDAI_A", 0x28C4c9Ceb0Bf527045D6Dea65Eb2b0D79820E573);
        CHANGELOG.setAddress("MCD_FLIP_USDNDAI_A", 0x816cCA35dD24dff4206C0875624D72b46aDEDD97);
        CHANGELOG.setAddress("USDTUSDN", 0xA005c4cb0FF752aEa9A7BCabA4215adA99C49433);
        CHANGELOG.setAddress("VAL_USDTUSDN", 0x182D5eae4Ed743208ad6D25C5Bf6fA1891351B70);
        CHANGELOG.setAddress("PIP_USDTUSDN", 0x182D5eae4Ed743208ad6D25C5Bf6fA1891351B70);
        CHANGELOG.setAddress("MCD_JOIN_USDTUSDN_A", 0xe3BB4E788eb137fE581616eac8f680D1f119D5D6);
        CHANGELOG.setAddress("MCD_FLIP_USDTUSDN_A", 0xd97E4F3E3b9D5ec6A99Fe3d23473ba4F727E7050);
        CHANGELOG.setAddress("USDCUSDN", 0x30DaBEd27aF8Bdeec71D8b0CeEa0f6C954E1E060);
        CHANGELOG.setAddress("VAL_USDCUSDN", 0xAAD3bB09e1f70724f98F4d3755a70c6e97Efb7E5);
        CHANGELOG.setAddress("PIP_USDCUSDN", 0xAAD3bB09e1f70724f98F4d3755a70c6e97Efb7E5);
        CHANGELOG.setAddress("MCD_JOIN_USDCUSDN_A", 0x5e10834690deed8b82eAAa176503Df5e00c6A034);
        CHANGELOG.setAddress("MCD_FLIP_USDCUSDN_A", 0xF2594a5E55E133c9c0c4f3c20fe26532Ab862982);
        CHANGELOG.setAddress("PROXY_PAUSE_ACTIONS", 0x12B36b0B236049C1428153F5843888f976c27b78);
        CHANGELOG.setAddress("PROXY_DEPLOYER", 0xEFC4EaB735FEe322480A7c6e08A85a110421DD74);

        CHANGELOG.setVersion("1.0.0");
    }
}
