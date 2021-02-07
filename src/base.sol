pragma solidity 0.6.7;

import "./IERC20.sol";

interface IAdapter {
    function calc(
        address gem,
        uint256 acc,
        uint256 factor
    ) external view returns (uint256);
}

interface IGemForRewardChecker {
    function check(address gem) external view returns (bool);
}
