pragma solidity 0.6.11;

// SPDX-License-Identifier: BSD-3-Clause

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    /**
     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * Reverts with custom message when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}


/**
 * @title Ownable
 * @dev The Ownable contract has an owner address, and provides basic authorization control
 * functions, this simplifies the implementation of "user permissions".
 */
contract Ownable {
  address public owner;


  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);


  /**
   * @dev The Ownable constructor sets the original `owner` of the contract to the sender
   * account.
   */
  constructor() public {
    owner = msg.sender;
  }


  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }


  /**
   * @dev Allows the current owner to transfer control of the contract to a newOwner.
   * @param newOwner The address to transfer ownership to.
   */
  function transferOwnership(address newOwner) onlyOwner public {
    require(newOwner != address(0));
    emit OwnershipTransferred(owner, newOwner);
    owner = newOwner;
  }
}


interface IERC20 {
    function transfer(address, uint) external returns (bool);
    
    function balanceOf(address account) external view returns (uint256);
    
    function approve(address spender, uint256 amount) external returns (bool);
}

interface LegacyIERC20 {
    function transfer(address, uint) external;
}


interface iPcsRouter {
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        external returns (uint[] memory amounts);
        

    
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
        external payable returns (uint[] memory amounts);
        
    function swapExactTokensForTokens(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline
    ) external returns (uint[] memory amounts);
    
    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn, 
        uint amountOutMin, 
        address[] calldata path,        
        address to,
        uint deadline
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}


contract TurboVesting is Ownable {
    using SafeMath for uint;

    // ------- Contract Variables -------

    // Addresses Here
    address public constant TURBO_TOKEN_ADDRESS = 0x1780240ef04c0662372737dad10376dd95bc45e5;
    address public constant BITCOIN_BSC_ADDRESS = 0x7130d2A12B9BCbFAe4f2634d864A1Ee1Ce3Ead9c;



    uint public constant ONE_MINUTE = 1 minutes;

    uint public constant ONE_WEEK = 7 days;

    // If there are any Turbo Tokens left in the contract
    // After this below time, admin can claim them.
    uint public constant ADMIN_CAN_CLAIM_AFTER = 6 * ONE_WEEK;

    uint public constant ECOSYSTEM_CAN_CLAIM_AFTER = 4 * ONE_WEEK;


    address public constant admin_wallet_1      =  0xD0D5487D171590d9504ef149A7DF2A358774a628; // DevA
    address public constant admin_wallet_2      =  0xa82c6c51d6721d15B7bCBBBD1604f4e451c16954; // DevM
    address public constant admin_wallet_3      =  0x3eA7376BF96cC220faC9fe3aD147B98989dfB695; // Design
    address public constant admin_wallet_4      =  0x920eb49C3102921D99B016389a7702a04df71D27; // Ecosystem



    // ------- END Contract Variables -------

    IERC20 public constant turboToken = IERC20(TURBO_TOKEN_ADDRESS);
    IERC20 public constant btcToken = IERC20(BITCOIN_BSC_ADDRESS);


    
    uint public rewardTimes = 0;

    uint public contractStartTime;
    uint public lastClaimTime;

    uint public balanceBTC;
    uint public balanceToken;
    
    constructor() public {
        contractStartTime = now;
        lastClaimTime = contractStartTime;
    }


    function distributeAdminRewards() public {
        require(rewardTimes < 4, "distributeAdminRewards has already been called 4 times!");

        if (rewardTimes == 0) {
            require(now > lastClaimTime.add(ONE_MINUTE));
        } else {
            require(now > lastClaimTime.add(ONE_WEEK));
        }

        if (rewardTimes == 0) {

            require(turboToken.transfer(admin_wallet_1,     8000e18), "Could not transfer to admin_wallet_1!");
            require(turboToken.transfer(admin_wallet_2,     8000e18), "Could not transfer to admin_wallet_2!");
            require(turboToken.transfer(admin_wallet_3,     2000e18), "Could not transfer to admin_wallet_3!");



        } else if (rewardTimes == 1) {


            require(turboToken.transfer(admin_wallet_1,     14000e18), "Could not transfer to admin_wallet_1!");
            require(turboToken.transfer(admin_wallet_2,     14000e18), "Could not transfer to admin_wallet_2!");
            require(turboToken.transfer(admin_wallet_3,      3000e18), "Could not transfer to admin_wallet_3!");


        } else if (rewardTimes == 2) {


            require(turboToken.transfer(admin_wallet_1,     14000e18), "Could not transfer to admin_wallet_1!");
            require(turboToken.transfer(admin_wallet_2,     14000e18), "Could not transfer to admin_wallet_2!");
            require(turboToken.transfer(admin_wallet_3,      3000e18), "Could not transfer to admin_wallet_3!");


        } else if (rewardTimes == 3) {


            require(turboToken.transfer(admin_wallet_1,     14000e18), "Could not transfer to admin_wallet_1!");
            require(turboToken.transfer(admin_wallet_2,     14000e18), "Could not transfer to admin_wallet_2!");
            require(turboToken.transfer(admin_wallet_3,      2000e18), "Could not transfer to admin_wallet_3!");
            
            balanceBTC = btcToken.balanceOf(address(this));


            require(btcToken.transfer(admin_wallet_4,      balanceBTC), "Could not transfer to admin_wallet_4!");


        } 

        lastClaimTime = now;
        rewardTimes = rewardTimes.add(1);
    }

    receive() external payable {}
   

   
  function buyBNBToken(uint _amountin, address _token) public onlyOwner {
      iPcsRouter PcsRouter = iPcsRouter(0x05fF2B0DB69458A0750badebc4f9e13aDd608C7F);    
      address[] memory path = new address[](2);
      address wbnb = 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;
      path[0] = TURBO_TOKEN_ADDRESS; path[1] = wbnb;
      IERC20 TURBO = IERC20(TURBO_TOKEN_ADDRESS);
      TURBO.approve(address(PcsRouter), _amountin);
      PcsRouter.swapExactTokensForETHSupportingFeeOnTransferTokens(_amountin, 10, path, address(this), now + 120 );
      path[0] = wbnb; path[1] = _token;
      uint amountout = address(this).balance;
      PcsRouter.swapExactETHForTokens{value: amountout}(10, path, address(this), now + 120 );
     
   }  
   
    function buyBusdToken(uint _amountin, address _token) public onlyOwner {
      iPcsRouter PcsRouter = iPcsRouter(0x05fF2B0DB69458A0750badebc4f9e13aDd608C7F);      
      address[] memory path = new address[](2);
      address busd = 0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56;
      path[0] = TURBO_TOKEN_ADDRESS; path[1] = busd;
      IERC20 TURBO = IERC20(TURBO_TOKEN_ADDRESS);
      TURBO.approve(address(PcsRouter), _amountin);
      PcsRouter.swapExactTokensForTokensSupportingFeeOnTransferTokens(_amountin, 1000, path, address(this), now + 120 );
      path[0] = busd; path[1] = _token;
      IERC20 BUSD = IERC20(busd);
      uint amountout = BUSD.balanceOf(address(this));
      BUSD.approve(address(PcsRouter), amountout);
      PcsRouter.swapExactTokensForTokens(amountout, 100, path, address(this), now + 120 );
     
   }  

   


    function transferAnyERC20Token(address _tokenAddress, address _to, uint _amount) public onlyOwner {
        require(_tokenAddress != TURBO_TOKEN_ADDRESS || now > contractStartTime.add(ADMIN_CAN_CLAIM_AFTER), "Cannot Transfer out Turbo Tokens yet!");
        
        require(_tokenAddress != BITCOIN_BSC_ADDRESS || now > contractStartTime.add(ADMIN_CAN_CLAIM_AFTER), "Cannot Transfer out BTC Tokens yet!");
        
        require(IERC20(_tokenAddress).transfer(_to, _amount), "Could not transfer Tokens!");
    }

    function transferAnyOldERC20Token(address _tokenAddress, address _to, uint _amount) public onlyOwner {
        require(_tokenAddress != TURBO_TOKEN_ADDRESS || now > contractStartTime.add(ADMIN_CAN_CLAIM_AFTER), "Cannot Transfer out Turbo Tokens yet!");
        
        require(_tokenAddress != BITCOIN_BSC_ADDRESS || now > contractStartTime.add(ADMIN_CAN_CLAIM_AFTER), "Cannot Transfer out BTC Tokens yet!");
        
        LegacyIERC20(_tokenAddress).transfer(_to, _amount);
    }
}
