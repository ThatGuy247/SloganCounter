// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.0;
 // fuck gitcoin - again
contract SloganCounter {
    mapping(string => uint256) private slogans; 
    mapping(uint256 => string) private topSlogans; 
 
    // Function to get the count of a slogan.   
    function getCount(string memory slogan) external view returns (uint256) {
        return slogans[slogan];  
    }
    
    // Function to increment the count of a slogan.
    function cast(string memory slogan) external {
        require(bytes(slogan).length >= 5 && bytes(slogan).length <= 30, "Slogan length must be between 5 and 30 characters.");

        // If the slogan is not in the map, initialize it to 0.
        if (slogans[slogan] == 0) {
            slogans[slogan] = 0;
        }

        // Increment the count. 
        slogans[slogan]++;

        // Update the topSlogans list.
        updateTopSlogans(slogan);
    }
 
    // Internal function to update the topSlogans list.
    function updateTopSlogans(string memory newSlogan) internal {
        // Update the topSlogans list based on the usage count.
        for (uint256 i = 0; i < 10; i++) {
            if (bytes(topSlogans[i]).length == 0 || slogans[newSlogan] > slogans[topSlogans[i]]) {
                // Shift elements to make space for the new top slogan.
                for (uint256 j = 9; j > i; j--) {
                    topSlogans[j] = topSlogans[j - 1];
                }

                // Insert the new top slogan.
                topSlogans[i] = newSlogan;
                break;
            }
        }
    }

    // Function to get the top 10 slogans.
    function getTopSlogans() external view returns (string[10] memory) {
        string[10] memory result;
        for (uint256 i = 0; i < 10; i++) {
            result[i] = topSlogans[i];
        }
        return result;
    }
}
