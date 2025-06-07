// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract MyContracts {
    string public textRaw;
    address private owner;
    uint256 public angka;

    struct Pembelian {
        string namaProduk;
        uint256 jumlahBayar;
    }

    mapping(address => Pembelian[]) public riwayatPembelian;

    event PembelianBerhasil(address indexed pembeli, string namaProduk, uint256 jumlahBayar);

    constructor() {
        owner = msg.sender;
    }

    function setText(string calldata _text) external {
        textRaw = _text;
    }

    function inc() external {
        require(msg.sender == owner, "You are not the owner");
        angka++;
    }

    function getPemilik() external view returns (address) {
        return owner;
    }

    function beli(string calldata namaProduk) external payable {
    uint256 harga;
    if (keccak256(bytes(namaProduk)) == keccak256("Bitcoin")) {
        harga = 0.01 ether;
    } else if (keccak256(bytes(namaProduk)) == keccak256("Ethereum")) {
        harga = 0.02 ether;
    } else if (keccak256(bytes(namaProduk)) == keccak256("Dogecoin")) {
        harga = 0.005 ether;
    } else {
            revert("Produk tidak dikenal");
        }

        require(msg.value == harga, "Pembayaran tidak sesuai harga");

        riwayatPembelian[msg.sender].push(Pembelian(namaProduk, msg.value));
        emit PembelianBerhasil(msg.sender, namaProduk, msg.value);
    }

    function getRiwayatCount(address pembeli) external view returns (uint256) {
        return riwayatPembelian[pembeli].length;
    }

    function getBalance(address user) external view returns (uint256) {
        return user.balance;
    }
}
