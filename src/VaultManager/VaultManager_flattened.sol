// SPDX-License-Identifier: MIT
// File: VaultManager/IVaultManager.sol


pragma solidity =0.8.25;

interface IVaultManager {
    function createVault(address[] memory _initialAssets, uint8 _performanceFee) external;

    function addTrader(address _trader) external;

    function removeTrader(address _trader) external;

    function executeTrade(
        uint256 _vaultIndex,
        address _asset1,
        uint256 _amount1,
        address _asset2,
        uint256 _amount2
    )
        external;
}

// File: Trade/ITrade.sol


pragma solidity =0.8.25;

interface ITradingContract {
    function swapExactInputSingle(
        address tokenIn,
        address tokenOut,
        uint256 amountIn,
        uint256 amountOutMin,
        address recipient,
        uint8 poolFee
    )
        external
        returns (uint256 amountOut);
}

// File: @chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol


pragma solidity ^0.8.0;

interface AggregatorV3Interface {
  function decimals() external view returns (uint8);

  function description() external view returns (string memory);

  function version() external view returns (uint256);

  function getRoundData(
    uint80 _roundId
  ) external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);

  function latestRoundData()
    external
    view
    returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
}

// File: @openzeppelin/contracts/utils/introspection/IERC165.sol


// OpenZeppelin Contracts (last updated v5.0.0) (utils/introspection/IERC165.sol)

pragma solidity ^0.8.20;

/**
 * @dev Interface of the ERC165 standard, as defined in the
 * https://eips.ethereum.org/EIPS/eip-165[EIP].
 *
 * Implementers can declare support of contract interfaces, which can then be
 * queried by others ({ERC165Checker}).
 *
 * For an implementation, see {ERC165}.
 */
interface IERC165 {
    /**
     * @dev Returns true if this contract implements the interface defined by
     * `interfaceId`. See the corresponding
     * https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[EIP section]
     * to learn more about how these ids are created.
     *
     * This function call must use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

// File: @openzeppelin/contracts/utils/introspection/ERC165.sol


// OpenZeppelin Contracts (last updated v5.0.0) (utils/introspection/ERC165.sol)

pragma solidity ^0.8.20;


/**
 * @dev Implementation of the {IERC165} interface.
 *
 * Contracts that want to implement ERC165 should inherit from this contract and override {supportsInterface} to check
 * for the additional interface id that will be supported. For example:
 *
 * ```solidity
 * function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
 *     return interfaceId == type(MyInterface).interfaceId || super.supportsInterface(interfaceId);
 * }
 * ```
 */
abstract contract ERC165 is IERC165 {
    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId) public view virtual returns (bool) {
        return interfaceId == type(IERC165).interfaceId;
    }
}

// File: @openzeppelin/contracts/utils/Context.sol


// OpenZeppelin Contracts (last updated v5.0.1) (utils/Context.sol)

pragma solidity ^0.8.20;

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }

    function _contextSuffixLength() internal view virtual returns (uint256) {
        return 0;
    }
}

// File: @openzeppelin/contracts/access/IAccessControl.sol


// OpenZeppelin Contracts (last updated v5.0.0) (access/IAccessControl.sol)

pragma solidity ^0.8.20;

/**
 * @dev External interface of AccessControl declared to support ERC165 detection.
 */
interface IAccessControl {
    /**
     * @dev The `account` is missing a role.
     */
    error AccessControlUnauthorizedAccount(address account, bytes32 neededRole);

    /**
     * @dev The caller of a function is not the expected one.
     *
     * NOTE: Don't confuse with {AccessControlUnauthorizedAccount}.
     */
    error AccessControlBadConfirmation();

    /**
     * @dev Emitted when `newAdminRole` is set as ``role``'s admin role, replacing `previousAdminRole`
     *
     * `DEFAULT_ADMIN_ROLE` is the starting admin for all roles, despite
     * {RoleAdminChanged} not being emitted signaling this.
     */
    event RoleAdminChanged(bytes32 indexed role, bytes32 indexed previousAdminRole, bytes32 indexed newAdminRole);

    /**
     * @dev Emitted when `account` is granted `role`.
     *
     * `sender` is the account that originated the contract call, an admin role
     * bearer except when using {AccessControl-_setupRole}.
     */
    event RoleGranted(bytes32 indexed role, address indexed account, address indexed sender);

    /**
     * @dev Emitted when `account` is revoked `role`.
     *
     * `sender` is the account that originated the contract call:
     *   - if using `revokeRole`, it is the admin role bearer
     *   - if using `renounceRole`, it is the role bearer (i.e. `account`)
     */
    event RoleRevoked(bytes32 indexed role, address indexed account, address indexed sender);

    /**
     * @dev Returns `true` if `account` has been granted `role`.
     */
    function hasRole(bytes32 role, address account) external view returns (bool);

    /**
     * @dev Returns the admin role that controls `role`. See {grantRole} and
     * {revokeRole}.
     *
     * To change a role's admin, use {AccessControl-_setRoleAdmin}.
     */
    function getRoleAdmin(bytes32 role) external view returns (bytes32);

    /**
     * @dev Grants `role` to `account`.
     *
     * If `account` had not been already granted `role`, emits a {RoleGranted}
     * event.
     *
     * Requirements:
     *
     * - the caller must have ``role``'s admin role.
     */
    function grantRole(bytes32 role, address account) external;

    /**
     * @dev Revokes `role` from `account`.
     *
     * If `account` had been granted `role`, emits a {RoleRevoked} event.
     *
     * Requirements:
     *
     * - the caller must have ``role``'s admin role.
     */
    function revokeRole(bytes32 role, address account) external;

    /**
     * @dev Revokes `role` from the calling account.
     *
     * Roles are often managed via {grantRole} and {revokeRole}: this function's
     * purpose is to provide a mechanism for accounts to lose their privileges
     * if they are compromised (such as when a trusted device is misplaced).
     *
     * If the calling account had been granted `role`, emits a {RoleRevoked}
     * event.
     *
     * Requirements:
     *
     * - the caller must be `callerConfirmation`.
     */
    function renounceRole(bytes32 role, address callerConfirmation) external;
}

// File: @openzeppelin/contracts/access/AccessControl.sol


// OpenZeppelin Contracts (last updated v5.0.0) (access/AccessControl.sol)

pragma solidity ^0.8.20;




/**
 * @dev Contract module that allows children to implement role-based access
 * control mechanisms. This is a lightweight version that doesn't allow enumerating role
 * members except through off-chain means by accessing the contract event logs. Some
 * applications may benefit from on-chain enumerability, for those cases see
 * {AccessControlEnumerable}.
 *
 * Roles are referred to by their `bytes32` identifier. These should be exposed
 * in the external API and be unique. The best way to achieve this is by
 * using `public constant` hash digests:
 *
 * ```solidity
 * bytes32 public constant MY_ROLE = keccak256("MY_ROLE");
 * ```
 *
 * Roles can be used to represent a set of permissions. To restrict access to a
 * function call, use {hasRole}:
 *
 * ```solidity
 * function foo() public {
 *     require(hasRole(MY_ROLE, msg.sender));
 *     ...
 * }
 * ```
 *
 * Roles can be granted and revoked dynamically via the {grantRole} and
 * {revokeRole} functions. Each role has an associated admin role, and only
 * accounts that have a role's admin role can call {grantRole} and {revokeRole}.
 *
 * By default, the admin role for all roles is `DEFAULT_ADMIN_ROLE`, which means
 * that only accounts with this role will be able to grant or revoke other
 * roles. More complex role relationships can be created by using
 * {_setRoleAdmin}.
 *
 * WARNING: The `DEFAULT_ADMIN_ROLE` is also its own admin: it has permission to
 * grant and revoke this role. Extra precautions should be taken to secure
 * accounts that have been granted it. We recommend using {AccessControlDefaultAdminRules}
 * to enforce additional security measures for this role.
 */
abstract contract AccessControl is Context, IAccessControl, ERC165 {
    struct RoleData {
        mapping(address account => bool) hasRole;
        bytes32 adminRole;
    }

    mapping(bytes32 role => RoleData) private _roles;

    bytes32 public constant DEFAULT_ADMIN_ROLE = 0x00;

    /**
     * @dev Modifier that checks that an account has a specific role. Reverts
     * with an {AccessControlUnauthorizedAccount} error including the required role.
     */
    modifier onlyRole(bytes32 role) {
        _checkRole(role);
        _;
    }

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId) public view virtual override returns (bool) {
        return interfaceId == type(IAccessControl).interfaceId || super.supportsInterface(interfaceId);
    }

    /**
     * @dev Returns `true` if `account` has been granted `role`.
     */
    function hasRole(bytes32 role, address account) public view virtual returns (bool) {
        return _roles[role].hasRole[account];
    }

    /**
     * @dev Reverts with an {AccessControlUnauthorizedAccount} error if `_msgSender()`
     * is missing `role`. Overriding this function changes the behavior of the {onlyRole} modifier.
     */
    function _checkRole(bytes32 role) internal view virtual {
        _checkRole(role, _msgSender());
    }

    /**
     * @dev Reverts with an {AccessControlUnauthorizedAccount} error if `account`
     * is missing `role`.
     */
    function _checkRole(bytes32 role, address account) internal view virtual {
        if (!hasRole(role, account)) {
            revert AccessControlUnauthorizedAccount(account, role);
        }
    }

    /**
     * @dev Returns the admin role that controls `role`. See {grantRole} and
     * {revokeRole}.
     *
     * To change a role's admin, use {_setRoleAdmin}.
     */
    function getRoleAdmin(bytes32 role) public view virtual returns (bytes32) {
        return _roles[role].adminRole;
    }

    /**
     * @dev Grants `role` to `account`.
     *
     * If `account` had not been already granted `role`, emits a {RoleGranted}
     * event.
     *
     * Requirements:
     *
     * - the caller must have ``role``'s admin role.
     *
     * May emit a {RoleGranted} event.
     */
    function grantRole(bytes32 role, address account) public virtual onlyRole(getRoleAdmin(role)) {
        _grantRole(role, account);
    }

    /**
     * @dev Revokes `role` from `account`.
     *
     * If `account` had been granted `role`, emits a {RoleRevoked} event.
     *
     * Requirements:
     *
     * - the caller must have ``role``'s admin role.
     *
     * May emit a {RoleRevoked} event.
     */
    function revokeRole(bytes32 role, address account) public virtual onlyRole(getRoleAdmin(role)) {
        _revokeRole(role, account);
    }

    /**
     * @dev Revokes `role` from the calling account.
     *
     * Roles are often managed via {grantRole} and {revokeRole}: this function's
     * purpose is to provide a mechanism for accounts to lose their privileges
     * if they are compromised (such as when a trusted device is misplaced).
     *
     * If the calling account had been revoked `role`, emits a {RoleRevoked}
     * event.
     *
     * Requirements:
     *
     * - the caller must be `callerConfirmation`.
     *
     * May emit a {RoleRevoked} event.
     */
    function renounceRole(bytes32 role, address callerConfirmation) public virtual {
        if (callerConfirmation != _msgSender()) {
            revert AccessControlBadConfirmation();
        }

        _revokeRole(role, callerConfirmation);
    }

    /**
     * @dev Sets `adminRole` as ``role``'s admin role.
     *
     * Emits a {RoleAdminChanged} event.
     */
    function _setRoleAdmin(bytes32 role, bytes32 adminRole) internal virtual {
        bytes32 previousAdminRole = getRoleAdmin(role);
        _roles[role].adminRole = adminRole;
        emit RoleAdminChanged(role, previousAdminRole, adminRole);
    }

    /**
     * @dev Attempts to grant `role` to `account` and returns a boolean indicating if `role` was granted.
     *
     * Internal function without access restriction.
     *
     * May emit a {RoleGranted} event.
     */
    function _grantRole(bytes32 role, address account) internal virtual returns (bool) {
        if (!hasRole(role, account)) {
            _roles[role].hasRole[account] = true;
            emit RoleGranted(role, account, _msgSender());
            return true;
        } else {
            return false;
        }
    }

    /**
     * @dev Attempts to revoke `role` to `account` and returns a boolean indicating if `role` was revoked.
     *
     * Internal function without access restriction.
     *
     * May emit a {RoleRevoked} event.
     */
    function _revokeRole(bytes32 role, address account) internal virtual returns (bool) {
        if (hasRole(role, account)) {
            _roles[role].hasRole[account] = false;
            emit RoleRevoked(role, account, _msgSender());
            return true;
        } else {
            return false;
        }
    }
}

// File: @openzeppelin/contracts/token/ERC20/IERC20.sol


// OpenZeppelin Contracts (last updated v5.0.0) (token/ERC20/IERC20.sol)

pragma solidity ^0.8.20;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /**
     * @dev Returns the value of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the value of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves a `value` amount of tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 value) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets a `value` amount of tokens as the allowance of `spender` over the
     * caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 value) external returns (bool);

    /**
     * @dev Moves a `value` amount of tokens from `from` to `to` using the
     * allowance mechanism. `value` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address from, address to, uint256 value) external returns (bool);
}

// File: AssetVault/AssetVault.sol


pragma solidity =0.8.25;





contract AssetVault is AccessControl {
    struct UserShares {
        uint256 totalShares;
        mapping(address => uint256) assetShares;
    }

    mapping(address => UserShares) private userShares;

    AggregatorV3Interface internal dataFeed;
    bytes32 public constant VAULT_MANAGER_ROLE = keccak256("VAULT_MANAGER_ROLE");
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    IERC20[] public supportedAssets;
    mapping(address => uint256) public totalVaultBalance;
    mapping(address => AggregatorV3Interface) assetToOracle; // Store oracle addresses
    // mapping(address => uint256) public userProfits;

    address private _admin;
    uint8 public performanceFeePercentage;
    uint256 public lastRecordedProfit;
    uint256 public totalProfits;
    ITradingContract public tradeContract;

    constructor(address _vaultManager, address[] memory _initialAssets, uint8 _performanceFee, address _owner) {
        grantRole(VAULT_MANAGER_ROLE, _vaultManager);
        grantRole(DEFAULT_ADMIN_ROLE, _owner);
        _admin = _owner;
        _setRoleAdmin(VAULT_MANAGER_ROLE, ADMIN_ROLE); // Admins can manage vault manager role
        for (uint256 i = 0; i < _initialAssets.length; i++) {
            supportedAssets.push(IERC20(_initialAssets[i]));
        }
        performanceFeePercentage = _performanceFee;
        lastRecordedProfit = 0; // Initialize on contract creation
    }

    function setTradeContract(address _tradeContract) external onlyRole(ADMIN_ROLE) {
        tradeContract = ITradingContract(_tradeContract);
    }

    function setAssetToOracle(address _asset, address _oracle) external onlyRole(ADMIN_ROLE) {
        assetToOracle[_asset] = AggregatorV3Interface(_oracle);
    }

    // Add a function to update performance fees and check for roles
    function updatePerformanceFee(uint8 _newFee) external onlyRole(ADMIN_ROLE) {
        performanceFeePercentage = _newFee;
    }

    function estimateVaultValue() public view returns (uint256) {
        uint256 totalValue = 0;
        for (uint256 i = 0; i < supportedAssets.length; i++) {
            totalValue +=
                estimateAssetValue(address(supportedAssets[i]), totalVaultBalance[address(supportedAssets[i])]);
        }
        return totalValue;
    }

    function deposit(address _asset, uint256 _amount) external {
        require(isAssetSupported(IERC20(_asset)), "Asset not supported");
        IERC20(_asset).transferFrom(_msgSender(), address(this), _amount);
        totalVaultBalance[_asset] += _amount;
        userShares[_msgSender()].totalShares += estimateAssetValue(_asset, _amount);
        userShares[_msgSender()].assetShares[_asset] += _amount;
    }

    function withdrawProfits() external {
        uint256 profitShare = calculateUserProfitShare(_msgSender());
        // userProfits[_msgSender()] = 0;
        IERC20(address(supportedAssets[0])).transfer(_msgSender(), profitShare);
    }

    function withdraw(address _asset, uint256 _amount) external {
        require(userShares[_msgSender()].assetShares[_asset] >= _amount, "Insufficient balance");
        totalVaultBalance[_asset] -= _amount;

        // Proportional Profit Calculation (more on this below)
        uint256 profitShare = calculateUserProfitShare(_msgSender());
        // Distribute profits to user
        uint256 vaultShare = profitShare * performanceFeePercentage / 100;
        // Transfer Fees to the vault
        uint256 userShare = profitShare - vaultShare;

        uint256 currentAssetShares = userShares[_msgSender()].assetShares[_asset] - _amount;
        // Update user deposit records accordingly
        userShares[_msgSender()].totalShares -= estimateAssetValue(_asset, currentAssetShares);
        userShares[_msgSender()].assetShares[_asset] = currentAssetShares;

        IERC20(_asset).transfer(_admin, vaultShare);
        IERC20(_asset).transfer(_msgSender(), userShare);
    }

    function calculateUserProfitShare(address _user) internal view returns (uint256) {
        uint256 userShare = (userShares[_user].totalShares * 1e18) / estimateVaultValue();
        uint256 profitShare = (totalProfits * userShare) / 1e18;
        return profitShare;
    }

    function trade(
        address _asset1,
        uint256 _amount1,
        address _asset2,
        uint256 _amount2
    )
        external
        onlyRole(VAULT_MANAGER_ROLE)
    {
        // Logic to execute the trade on Uniswap
        tradeContract.swapExactInputSingle(
            _asset1, _asset2, _amount1, _amount2, address(this), performanceFeePercentage
        );

        // Simplified profit estimation:
        uint256 currentValue = estimateAssetValue(address(_asset2), _amount2); // Assuming you fetch the value of
            // received assets
        uint256 previousValue = estimateAssetValue(address(_asset1), _amount1);
        uint256 profit = currentValue - previousValue;
        totalProfits += profit;
    }

    function isAssetSupported(IERC20 _asset) internal view returns (bool) {
        for (uint256 i = 0; i < supportedAssets.length; i++) {
            if (supportedAssets[i] == _asset) {
                return true;
            }
        }
        return false;
    }

    function estimateAssetValue(address _asset, uint256 _amount) public view returns (uint256 valueUSD) {
        AggregatorV3Interface priceFeed = assetToOracle[_asset];
        require(priceFeed != AggregatorV3Interface(address(0)), "Oracle not set for asset");
        (, int256 price,,,) = priceFeed.latestRoundData();
        require(price > 0, "Invalid price data");
        uint256 decimals = uint256(priceFeed.decimals());
        uint256 val = (_amount * uint256(price)) / (10 ** decimals);
        return val;
    }

    // Helper to calculate current price per share
    function currentPricePerShare(address asset) public view returns (uint256) {
        uint256 totalAssetValue = estimateAssetValue(asset, totalVaultBalance[asset]);
        uint256 totalShares = userShares[address(0)].assetShares[asset]; // Total shares for the asset
        return totalShares == 0 ? 1e18 : totalAssetValue / totalShares; // 1e18 is the initial share price
    }
}

// File: VaultManager/VaultManager.sol


pragma solidity =0.8.25;




contract VaultManager is AccessControl, IVaultManager {
    bytes32 public constant TRADER_ROLE = keccak256("TRADER_ROLE");
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");

    AssetVault[] public managedVaults;

    constructor() {
        _grantRole(DEFAULT_ADMIN_ROLE, _msgSender()); // Deployer gets admin role
        _setRoleAdmin(TRADER_ROLE, ADMIN_ROLE); // Admins can manage trader role
    }

    function createVault(address[] memory _initialAssets, uint8 _performanceFee) external onlyRole(ADMIN_ROLE) {
        AssetVault newVault = new AssetVault(address(this), _initialAssets, _performanceFee, _msgSender());
        managedVaults.push(newVault);
    }

    function addTrader(address _trader) external onlyRole(ADMIN_ROLE) {
        grantRole(TRADER_ROLE, _trader);
    }

    function removeTrader(address _trader) external onlyRole(ADMIN_ROLE) {
        revokeRole(TRADER_ROLE, _trader);
    }

    function executeTrade(
        uint256 _vaultIndex,
        address _asset1,
        uint256 _amount1,
        address _asset2,
        uint256 _amount2
    )
        external
        onlyRole(TRADER_ROLE)
    {
        AssetVault vault = managedVaults[_vaultIndex];
        vault.trade(_asset1, _amount1, _asset2, _amount2);
    }
}