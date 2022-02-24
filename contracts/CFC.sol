pragma solidity 0.5.10;

import "./BEP20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";

contract GlobalsAndUtility is BEP20 {

    using SafeMath for uint256;
    uint public TAX_FEE = 5;
    uint public BURN_FEE = 5;
    address public owner;
    mapping (address => bool) public excludedFromTax;

    /* Accounting */
    address payable public deployer =
    0xBA28B6BbDeb90865579763c32Ab2e5205080211C;

    uint8 internal LAST_FLUSHED_DAY = 1;

    /* BEP20 constants */
    string public constant Name = "ChronoFi";
    string public constant Symbol = "CFC";
    uint8 public constant decimals = 18;

    /* Suns per Satoshi = 10,000 * 1e8 / 1e8 = 1e4 */
    uint256 private constant SUNS_PER_DIV = 10**uint256(decimals); // 1e18

    /* Time of contract launch (2021-10-11T00:00:00Z) */
    uint256 internal constant LAUNCH_TIME = 1635966980;

    constructor() public {
        _mint(msg.sender, 1000 * 10 ** 18);
        owner = msg.sender;
        excludedFromTax[msg.sender] = true;
    }

    function transfer(address recipient, uint256 amount) public returns (bool) 
    {
        if (excludedFromTax[msg.sender] == true) 
        {
            _transfer(_msgSender(), recipient, amount);
        }
        else
        {
            uint burnt = amount.mul(BURN_FEE)/100;
            uint admamt = amount.mul(TAX_FEE)/100;
            _burn(_msgSender(), burnt);
            _transfer(_msgSender(), owner, admamt);
            _transfer(_msgSender(),recipient, amount.sub(burnt).sub(admamt));
        }
        return true;
    }

    
}