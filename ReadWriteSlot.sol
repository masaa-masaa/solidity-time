// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;


contract ReadWriteSlot {
    struct Num {
        uint256 val;
        uint16  pay;
        uint16 fee;
    }

   

    function storageFind() external returns (bytes32 SLOT) {
        SLOT = keccak256("MASAA");
        Num storage  x;
        assembly {
            x.slot := SLOT
        }
        x.val = 234; x.pay= 5555; x.fee = 777;
    }

    function readSlot(bytes32 SLOT) external view returns (uint256) {
        assembly {
            let val := sload(SLOT)
            mstore(0x00, val)
            return(0x00, 0x20)
        }
    }

    function nextSlot(bytes32 SLOT, uint256 offset)  external view returns(uint256){
      assembly {
            let val := sload(add(SLOT, offset))
            mstore(0x00, val)
            return(0x00, 0x20)
        }
    }
}
