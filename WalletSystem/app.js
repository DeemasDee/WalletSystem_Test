// URL Backend
const API_URL = 'http://localhost:3000';

// Fungsi untuk menampilkan elemen yang dibutuhkan
function showDashboard() {
  document.getElementById('login').classList.add('hidden');
  document.getElementById('dashboard').classList.remove('hidden');
  document.getElementById('create-wallet').classList.add('hidden');
  document.getElementById('transaction').classList.add('hidden');
  getBalance();
}

function showCreateWallet() {
  document.getElementById('dashboard').classList.add('hidden');
  document.getElementById('create-wallet').classList.remove('hidden');
}

function showTransaction() {
  document.getElementById('dashboard').classList.add('hidden');
  document.getElementById('transaction').classList.remove('hidden');
}

// Fungsi Login
async function login() {
  const username = document.getElementById('username').value;
  const password = document.getElementById('password').value;

  const response = await fetch(`${API_URL}/login`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ username, password }),
    credentials: 'include'
  });

  if (response.ok) {
    showDashboard();
  } else {
    alert('Login gagal');
  }
}

// Fungsi untuk mendapatkan saldo wallet
async function getBalance() {
  const response = await fetch(`${API_URL}/wallets/1/balance`, { credentials: 'include' });
  const data = await response.json();

  if (response.ok && data.balance !== undefined) {
    document.getElementById('balance').textContent = data.balance;
  } else {
    alert('Gagal mendapatkan saldo');
  }
}

// Fungsi untuk membuat wallet
async function createWallet() {
  const initialBalance = document.getElementById('initialBalance').value;

  const response = await fetch(`${API_URL}/wallets`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ wallet: { balance: initialBalance } }),
    credentials: 'include'
  });

  if (response.ok) {
    alert('Wallet berhasil dibuat');
    showDashboard();
  } else {
    alert('Gagal membuat wallet');
  }
}

// Fungsi untuk melakukan transaksi
async function makeTransaction() {
  const amount = document.getElementById('transactionAmount').value;
  const sourceWalletId = document.getElementById('sourceWallet').value;
  const targetWalletId = document.getElementById('targetWallet').value;

  const response = await fetch(`${API_URL}/transactions`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      transaction: {
        amount: parseFloat(amount),
        source_wallet_id: parseInt(sourceWalletId),
        target_wallet_id: parseInt(targetWalletId)
      }
    }),
    credentials: 'include'
  });

  if (response.ok) {
    alert('Transaksi berhasil');
    showDashboard();
  } else {
    alert('Gagal melakukan transaksi');
  }
}
