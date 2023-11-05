// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract FruitTree {
    struct Tree {
        uint id;
        string variety;
        string origin;
        uint plantedAt;
        uint floweredAt;
        uint harvestedAt;
        bool isMature;
    }

    Tree[] public trees;

    event TreeStatusUpdated(uint treeId, uint floweredAt, uint harvestedAt);
    event TreePlanted(uint treeId, string variety, string origin);
    event TreeMatured(uint treeId);

    function plantTree(string memory _variety, string memory _origin) public {
        uint id = trees.length;
        trees.push(Tree(id, _variety, _origin, block.timestamp, 0, 0, false));

        emit TreePlanted(id, _variety, _origin);
    }

    function updateTreeStatus(
        uint _treeId,
        uint _floweredAt,
        uint _harvestedAt
    ) public {
        Tree storage myTree = trees[_treeId];
        myTree.floweredAt = _floweredAt;
        myTree.harvestedAt = _harvestedAt;

        emit TreeStatusUpdated(_treeId, _floweredAt, _harvestedAt);

        if (_floweredAt > 0 && _harvestedAt > 0 && !myTree.isMature) {
            myTree.isMature = true;
            emit TreeMatured(_treeId);
        }
    }

    function deleteTree(uint _treeId) public {
        delete trees[_treeId];
    }

    function getTree(uint _treeId) public view returns (Tree memory) {
        return trees[_treeId];
    }

    function searchTreeByVariety(
        string memory _variety
    ) public view returns (Tree[] memory) {
        uint count = 0;
        for (uint i = 0; i < trees.length; i++) {
            if (
                keccak256(abi.encodePacked(trees[i].variety)) ==
                keccak256(abi.encodePacked(_variety))
            ) {
                count++;
            }
        }

        Tree[] memory result = new Tree[](count);

        uint index = 0;
        for (uint i = 0; i < trees.length; i++) {
            if (
                keccak256(abi.encodePacked(trees[i].variety)) ==
                keccak256(abi.encodePacked(_variety))
            ) {
                result[index] = trees[i];
                index++;
            }
        }
        return result;
    }

    function getAllTrees(
        uint _start,
        uint _count
    ) public view returns (Tree[] memory) {
        require(_start < trees.length, "Start index out of range");
        require(_count > 0, "Count must be greater than 0");

        uint end = _start + _count;
        if (end > trees.length) {
            end = trees.length;
        }

        Tree[] memory result = new Tree[](end - _start);
        for (uint i = _start; i < end; i++) {
            result[i - _start] = trees[i];
        }
        return result;
    }
}
