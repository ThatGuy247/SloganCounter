// StarkNet contract
// This is a simplified translation of the Solidity contract to Cairo for StarkNet.
// Use this to store a Slogan and Count how many times it's been casted
// The Cairo standard library should be imported.
import  starkware.cairo.common as common

// Define the contract storage.
data SloganCounter:
    slogans: storage(map(string, felt))

// Initialize the contract.
@public
@init
def __init__():
    self.slogans = {}

// Function to get the count of a slogan.
@public
@view
def get_count(slogan: string) -> felt:
    return self.slogans[slogan]

// Function to increment the count of a slogan.
@public
def cast(slogan: string):
    # If the slogan is not in the map, initialize it to 0.
    if self.slogans[slogan] is none:
        self.slogans[slogan] = 0

    # Increment the count.
    self.slogans[slogan] += 1
