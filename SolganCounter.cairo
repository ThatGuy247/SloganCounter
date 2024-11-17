// StarkNet Contract - nah not a fan
// This is a modified version of the previous Cairo contract to store and show top 10 slogans. 
 
// The Cairo standard library should be imported. 
import starkware.cairo.common as common  
  
// Define the contract storage.   
data SloganCounter:  
    slogans: storage(map(string, felt)) 
    top_slogans: storage(list((string, felt)))

// Initialize the contract.
@public
@init 
def __init__():
    self.slogans = {}
    self.top_slogans = []

// Function to get the count of a slogan.
@public
@view
def get_count(slogan: string) -> felt:
    return self.slogans[slogan]

// Function to increment the count of a slogan.
@public
def cast(slogan: string):
    # Assert that the length of the input slogan is between 5 and 30 characters.
    assert 5 <= len(slogan) <= 30, "Slogan length must be between 5 and 30 characters."

    # If the slogan is not in the map, initialize it to 0.
    if self.slogans[slogan] is none:
        self.slogans[slogan] = 0

    # Increment the count.
    self.slogans[slogan] += 1

    # Update the top_slogans list.
    update_top_slogans(slogan)

# Internal function to update the top_slogans list.
@private
def update_top_slogans(new_slogan: string):
    # Update the top_slogans list based on the usage count.
    updated_top_slogans = sorted(self.slogans.items(), key=lambda x: x[1], reverse=True)[:10]

    # Assign the updated list to storage.
    self.top_slogans = updated_top_slogans
