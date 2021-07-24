//SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

library EnumerableNFTSet {
    struct NFT {
        // keccak256(abi.encodePacked(contractAddress,tokenId))
        address owner;
        address contractAddress;
        uint256 tokenId;
        uint256 amount;
    }

    struct Set {
        // Storage of set values
        NFT[] _values;
        // Position of the value in the `values` array, plus 1 because index 0
        // means a value is not in the set.
        mapping(address => mapping(uint256 => uint256)) _indexes;
    }

    /**
     * @dev Add a value to a set. O(1).
     *
     * Returns true if the value was added to the set, that is if it was not
     * already present.
     */
    function _add(Set storage set, NFT memory value) private returns (bool) {
        if (!_contains(set, value.contractAddress, value.tokenId)) {
            set._values.push(value);
            // The value is stored at length-1, but we add 1 to all indexes
            // and use 0 as a sentinel value
            set._indexes[value.contractAddress][value.tokenId] = set
            ._values
            .length;
            return true;
        } else {
            return false;
        }
    }

    /**
     * @dev Removes a value from a set. O(1).
     *
     * Returns true if the value was removed from the set, that is if it was
     * present.
     */
    function _remove(Set storage set, NFT memory value) private returns (bool) {
        // We read and store the value's index to prevent multiple reads from the same storage slot
        uint256 valueIndex = set._indexes[value.contractAddress][value.tokenId];

        if (valueIndex != 0) {
            // Equivalent to contains(set, value)
            // To delete an element from the _values array in O(1), we swap the element to delete with the last one in
            // the array, and then remove the last element (sometimes called as 'swap and pop').
            // This modifies the order of the array, as noted in {at}.

            uint256 toDeleteIndex = valueIndex - 1;
            uint256 lastIndex = set._values.length - 1;

            // When the value to delete is the last one, the swap operation is unnecessary. However, since this occurs
            // so rarely, we still do the swap anyway to avoid the gas cost of adding an 'if' statement.

            NFT memory lastvalue = set._values[lastIndex];

            // Move the last value to the index where the value to delete is
            set._values[toDeleteIndex] = lastvalue;
            // Update the index for the moved value
            set._indexes[lastvalue.contractAddress][
                lastvalue.tokenId
            ] = valueIndex; // Replace lastvalue's index to valueIndex

            // Delete the slot where the moved value was stored
            set._values.pop();

            // Delete the index for the deleted slot
            delete set._indexes[value.contractAddress][value.tokenId];

            return true;
        } else {
            return false;
        }
    }

    /**
     * @dev Returns true if the value is in the set. O(1).
     */
    function _contains(
        Set storage set,
        address contractAddress,
        uint256 tokenId
    ) private view returns (bool) {
        return set._indexes[contractAddress][tokenId] != 0;
    }

    /**
     * @dev Returns the number of values on the set. O(1).
     */
    function _length(Set storage set) private view returns (uint256) {
        return set._values.length;
    }

    /**
     * @dev Returns the value stored at position `index` in the set. O(1).
     *
     * Note that there are no guarantees on the ordering of values inside the
     * array, and it may change when more values are added or removed.
     *
     * Requirements:
     *
     * - `index` must be strictly less than {length}.
     */
    function _at(Set storage set, uint256 index)
        private
        view
        returns (NFT memory)
    {
        require(
            set._values.length > index,
            "EnumerableSet: index out of bounds"
        );
        return set._values[index];
    }

    function _atAsStorage(Set storage set, uint256 index)
        private
        view
        returns (NFT storage)
    {
        require(
            set._values.length > index,
            "EnumerableSet: index out of bounds"
        );
        return set._values[index];
    }

    // NFTSet

    struct NFTSet {
        Set _inner;
    }

    /**
     * @dev Add a value to a set. O(1).
     *
     * Returns true if the value was added to the set, that is if it was not
     * already present.
     */
    function add(NFTSet storage set, NFT memory value) internal returns (bool) {
        return _add(set._inner, value);
    }

    /**
     * @dev Removes a value from a set. O(1).
     *
     * Returns true if the value was removed from the set, that is if it was
     * present.
     */
    function remove(NFTSet storage set, NFT memory value)
        internal
        returns (bool)
    {
        return _remove(set._inner, value);
    }

    /**
     * @dev Returns true if the value is in the set. O(1).
     */
    function contains(
        NFTSet storage set,
        address contractAddress,
        uint256 tokenId
    ) internal view returns (bool) {
        return _contains(set._inner, contractAddress, tokenId);
    }

    /**
     * @dev Returns the number of values in the set. O(1).
     */
    function length(NFTSet storage set) internal view returns (uint256) {
        return _length(set._inner);
    }

    /**
     * @dev Returns the value stored at position `index` in the set. O(1).
     *
     * Note that there are no guarantees on the ordering of values inside the
     * array, and it may change when more values are added or removed.
     *
     * Requirements:
     *
     * - `index` must be strictly less than {length}.
     */
    function at(NFTSet storage set, uint256 index)
        internal
        view
        returns (NFT memory)
    {
        return _at(set._inner, index);
    }

    function atAsStorage(NFTSet storage set, uint256 index)
        internal
        view
        returns (NFT storage)
    {
        return _atAsStorage(set._inner, index);
    }

    function get(
        NFTSet storage set,
        address contractAddress,
        uint256 tokenId
    ) internal view returns (NFT memory) {
        return
            _at(set._inner, set._inner._indexes[contractAddress][tokenId] - 1);
    }

    function getAsStorage(
        NFTSet storage set,
        address contractAddress,
        uint256 tokenId
    ) internal view returns (NFT storage) {
        return
            _atAsStorage(
                set._inner,
                set._inner._indexes[contractAddress][tokenId] - 1
            );
    }
}
