// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title BlockTrail Explorer
 * @dev A simple contract that allows users to store, retrieve, and update
 *      metadata about blockchain trails/records.
 */
contract Project {
    struct Trail {
        string data;
        uint256 timestamp;
        address creator;
    }

    mapping(uint256 => Trail) private trails;
    uint256 public trailCount;

    /// @notice Create a new blockchain trail
    /// @param _data The description or metadata for the trail
    function createTrail(string memory _data) public {
        trailCount++;
        trails[trailCount] = Trail({
            data: _data,
            timestamp: block.timestamp,
            creator: msg.sender
        });
    }

    /// @notice Retrieve a trail by its ID
    /// @param _id The trail's unique identifier
    function getTrail(uint256 _id)
        public
        view
        returns (string memory, uint256, address)
    {
        require(_id > 0 && _id <= trailCount, "Invalid trail ID");
        Trail memory t = trails[_id];
        return (t.data, t.timestamp, t.creator);
    }

    /// @notice Update the data of an existing trail
    /// @param _id The trail ID
    /// @param _newData New description or metadata
    function updateTrail(uint256 _id, string memory _newData) public {
        require(_id > 0 && _id <= trailCount, "Invalid trail ID");
        Trail storage t = trails[_id];
        require(msg.sender == t.creator, "Only creator can update");
        t.data = _newData;
    }
}

