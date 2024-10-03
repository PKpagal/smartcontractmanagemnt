let signer;
let contract;

// Contract address and ABI
const contractAddress = '0x905BB4dCBA9684E0D99494D317175BCa3F2134D6';
const contractABI = [
    {
        "inputs": [
            { "internalType": "string", "name": "_name", "type": "string" },
            { "internalType": "uint256", "name": "_age", "type": "uint256" },
            { "internalType": "string", "name": "_post", "type": "string" }
        ],
        "name": "setDetails",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "getDetails",
        "outputs": [
            { "internalType": "string", "name": "", "type": "string" },
            { "internalType": "uint256", "name": "", "type": "uint256" },
            { "internalType": "string", "name": "", "type": "string" }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            { "internalType": "address", "name": "_address", "type": "address" }
        ],
        "name": "personDetails",
        "outputs": [
            { "internalType": "string", "name": "", "type": "string" },
            { "internalType": "uint256", "name": "", "type": "uint256" },
            { "internalType": "string", "name": "", "type": "string" }
        ],
        "stateMutability": "view",
        "type": "function"
    }
];

async function init() {
    if (typeof window.ethereum !== 'undefined') {
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        await provider.send("eth_requestAccounts", []);
        signer = provider.getSigner();
        contract = new ethers.Contract(contractAddress, contractABI, signer);
        console.log("MetaMask connected successfully.");
    } else {
        alert('MetaMask not detected. Please install MetaMask to interact with this dApp.');
        console.error('MetaMask not detected');
    }
}

window.onload = init;

// Set details
document.getElementById("setDetailsBtn").addEventListener("click", async () => {
    const name = document.getElementById("name").value;
    const age = document.getElementById("age").value;
    const post = document.getElementById("post").value;

    try {
        const tx = await contract.setDetails(name, age, post);
        await tx.wait();
        alert('Details set successfully!');
    } catch (error) {
        console.error(error);
        alert('Error setting details.');
    }
});

// Get details
document.getElementById("getDetailsBtn").addEventListener("click", async () => {
    try {
        const details = await contract.getDetails();
        document.getElementById("displayDetails").innerText =
            `Name: ${details[0]}, Age: ${details[1]}, Post: ${details[2]}`;
    } catch (error) {
        console.error(error);
        alert('Error retrieving details.');
    }
});

// Fetch details by address
document.getElementById("fetchByAddressBtn").addEventListener("click", async () => {
    const address = document.getElementById("address").value;

    try {
        const details = await contract.personDetails(address);
        document.getElementById("displayAddressDetails").innerText =
            `Name: ${details[0]}, Age: ${details[1]}, Post: ${details[2]}`;
    } catch (error) {
        console.error(error);
        alert('Error fetching details by address.');
    }
});
