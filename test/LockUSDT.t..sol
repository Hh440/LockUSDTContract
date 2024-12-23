// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/LockUSDT.sol";
import "src/USDT.sol";

import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract TestContract is Test {
    LockUSDT c;

    //address usdtAddress = address(0xdAC17F958D2ee523a2206206994597C13D831ec7);

    address testerAddress=  address(0x82Eb1ae21D52821EEb195F2c2c0D40e66b33c97D);

     USDT usdt;
 

    function setUp() public {

        usdt=  new USDT();

        c = new LockUSDT(address(usdt));
        
    }

    function testDepost() public{

         usdt.mint(testerAddress, 20 ether);

        vm.startPrank(testerAddress);

        vm.deal(testerAddress, 20 ether);
        usdt.approve(address(c),20 ether);  


        c.deposit(20 ether);


        assertEq(usdt.balanceOf(testerAddress), 0 );
        assertEq(usdt.balanceOf(address(c)), 20 ether);




        assertEq(c.pendingBalance(testerAddress), 20 ether,"ok");


        c.withdraw();

        assertEq(c.pendingBalance(testerAddress), 0,"ok");

        assertEq(usdt.balanceOf(testerAddress), 20 ether,"ok");

        vm.stopPrank();

        



    }
}
