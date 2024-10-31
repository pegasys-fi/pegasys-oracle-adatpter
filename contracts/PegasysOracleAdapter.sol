pragma solidity 0.8.24;

import "./interfaces/ISupraSValueFeed.sol";

/// @title Pegasys Oracle Adapter
/// @notice Adapter contract to convert Supra Oracle data to a format compatible with Chainlink oracles
/// @dev This contract adapt Supra oracle outputs to conform with Chainlink's expected inputs by ensuring that the output is formatted to a consistent number of decimals.
contract PegasysOracleAdapter {
    /// @notice Address of the SupraSValueFeed contract
    /// @dev Stores the interface of the Supra oracle
    ISupraSValueFeed public supraFeed;

    /// @notice Index of the specific price pair in the SupraSValueFeed
    uint256 public pairIndex;

    /// @notice The number of decimal places to standardize the price to
    /// @dev Chainlink uses 8 decimal places in its price feeds
    uint8 public immutable decimals = 8;

    /// @notice Creates a new PegasysOracleAdapter
    /// @param supraFeed_ The address of the SupraSValueFeed oracle
    /// @param pairIndex_ The index of the currency pair in the Supra feed
    constructor(address supraFeed_, uint256 pairIndex_) {
        require(supraFeed_ != address(0), "Invalid Supra Feed Address");
        supraFeed = ISupraSValueFeed(supraFeed_);
        pairIndex = pairIndex_;
    }

    /// @notice Retrieves the latest price from the SupraSValueFeed and adjusts the decimal places to match the BASE_UNIT
    /// @return price The latest formatted price from the oracle
    function latestAnswer() external view returns (int256) {
        ISupraSValueFeed.priceFeed memory data = supraFeed.getSvalue(pairIndex);
        int256 price = formatDecimals(data.price, uint8(data.decimals));
        return price;
    }

    /// @notice Adjusts the number of decimal places in the price to match BASE_UNIT
    /// @param price The original price from the oracle
    /// @param srcDecimals The original number of decimal places of the price
    /// @return The price adjusted to the number of decimal places defined by BASE_UNIT
    /// @dev This function handles the conversion logic, ensuring that the price is standardized regardless of the source decimals
    function formatDecimals(
        uint256 price,
        uint8 srcDecimals
    ) internal pure returns (int256) {
        if (decimals > srcDecimals) {
            price = price * (10 ** (decimals - srcDecimals));
        } else if (decimals < srcDecimals) {
            price = price / (10 ** (srcDecimals - decimals));
        }
        return int256(price);
    }
}
