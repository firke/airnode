// SPDX-License-Identifier: MIT
pragma solidity 0.8.2;

import "./IRequesterStore.sol";

interface IAirnodeParameterStore is IRequesterStore {
    event AirnodeParametersSet(
        bytes32 indexed airnodeId,
        address admin,
        string xpub,
        address[] authorizers
        );

    event WithdrawalRequested(
        bytes32 indexed airnodeId,
        uint256 indexed requesterIndex,
        bytes32 indexed withdrawalRequestId,
        address designatedWallet,
        address destination
        );

    event WithdrawalFulfilled(
        bytes32 indexed airnodeId,
        uint256 indexed requesterIndex,
        bytes32 indexed withdrawalRequestId,
        address designatedWallet,
        address destination,
        uint256 amount
        );

    function setAirnodeParameters(
        address admin,
        string calldata xpub,
        address[] calldata authorizers
        )
        external
        payable
        returns (bytes32 airnodeId);

    function requestWithdrawal(
        bytes32 airnodeId,
        uint256 requesterIndex,
        address designatedWallet,
        address destination
    )
        external;

    function fulfillWithdrawal(
        bytes32 withdrawalRequestId,
        bytes32 airnodeId,
        uint256 requesterIndex,
        address destination
        )
        external
        payable;

    function checkAuthorizationStatus(
        bytes32 airnodeId,
        bytes32 requestId,
        bytes32 endpointId,
        uint256 requesterIndex,
        address designatedWallet,
        address clientAddress
        )
        external
        view
        returns (bool status);

    function getAirnodeParameters(bytes32 airnodeId)
        external
        view
        returns (
            address admin,
            string memory xpub,
            address[] memory authorizers
        );
}
