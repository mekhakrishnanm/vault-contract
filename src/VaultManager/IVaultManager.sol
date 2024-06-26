// SPDX-License-Identifier: MIT
pragma solidity =0.8.25;
import { ITradingContract } from "../Trade/ITrade.sol";

interface IVaultManager {

    function getTraderContract() external view returns (ITradingContract);

    function createVault(address[] memory _initialAssets) external;

    function addTrader(address _trader) external;

    function removeTrader(address _trader) external;

    function executeTrade(
        uint256 _vaultIndex,
        address _asset1,
        uint256 _amount1,
        address _asset2
    )
        external;
}
