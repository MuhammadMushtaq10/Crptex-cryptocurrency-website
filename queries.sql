DROP DATABASE IF EXISTS cryptex;
CREATE DATABASE cryptex;

USE cryptex;

CREATE TABLE Account (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(255) NOT NULL UNIQUE,
    Email VARCHAR(255) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    Name VARCHAR(255) NOT NULL,
    IBAN VARCHAR(50) NOT NULL
);


CREATE TABLE Currency (
    CurrencyID VARCHAR(20) PRIMARY KEY,
    CurrencySymbol VARCHAR(20) NOT NULL UNIQUE,
    CurrencyName VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE CurrencyPriceHistory (
    CurrencyID VARCHAR(20),
    Timestamp DATETIME,
    Value DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (CurrencyID, Timestamp),
    CONSTRAINT FK_Currency FOREIGN KEY (CurrencyID) REFERENCES Currency (CurrencyID)
);

CREATE TABLE Wallet (
    WalletID INT ,
    CurrencySymbol VARCHAR(20) NOT NULL,
    Qty DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    PRIMARY KEY (WalletID, CurrencySymbol),
    CONSTRAINT FK_WUser FOREIGN KEY (WalletID) REFERENCES Account (UserID),
    CONSTRAINT FK_WCurrency FOREIGN KEY (CurrencySymbol) REFERENCES Currency (CurrencySymbol)
);

CREATE TABLE Portfolio (
    WalletID INT,
    Timestamp DATETIME,
    CurrencySymbol VARCHAR(20),
    Qty DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    Value DECIMAL(10,2),
    PRIMARY KEY (WalletID, Timestamp, CurrencySymbol),
    CONSTRAINT FK_PUser FOREIGN KEY (WalletID) REFERENCES Account (UserID),
    CONSTRAINT FK_PCurrency FOREIGN KEY (CurrencySymbol) REFERENCES Currency (CurrencySymbol)
);

CREATE TABLE Transaction (
    TransactionID INT PRIMARY KEY,
    SenderUserID INT NOT NULL,
    ReceiverUserID INT NOT NULL,
    CurrencySymbol VARCHAR(20) NOT NULL,
    Qty DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    Price DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    Timestamp DATETIME NOT NULL,
    CONSTRAINT FK_SUser FOREIGN KEY (SenderUserID) REFERENCES Account (UserID),
    CONSTRAINT FK_RUser FOREIGN KEY (ReceiverUserID) REFERENCES Account (UserID),
    CONSTRAINT FK_TUCurrency FOREIGN KEY (CurrencySymbol) REFERENCES Currency (CurrencySymbol)
);

CREATE TABLE Market (
    Pair VARCHAR(10) PRIMARY KEY,
    Status VARCHAR(10) NOT NULL DEFAULT 'Active',
    MinPrice DECIMAL(10,2)  NOT NULL DEFAULT 0.00,
    MaxPrice DECIMAL(10,2)  NOT NULL DEFAULT 0.00,
    MinQty DECIMAL(10,2)  NOT NULL DEFAULT 0.00,
    MaxQty DECIMAL(10,2)  NOT NULL DEFAULT 0.00,
    QtyStepSize DECIMAL(10,2)  NOT NULL DEFAULT 0.00
);

CREATE TABLE MarketPriceHistory (
    Pair VARCHAR(10),
    Timestamp DATETIME,
    Price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (Pair, Timestamp),
    CONSTRAINT FK_Market FOREIGN KEY (Pair) REFERENCES Market (Pair)
);

CREATE TABLE SpotOrder (
    OrderID INT PRIMARY KEY,
    UserID INT NOT NULL,
    Pair VARCHAR(10) NOT NULL,
    BuySellIndicator VARCHAR(4) NOT NULL,
    Status VARCHAR(20) NOT NULL,
    OrderType VARCHAR(20) NOT NULL,
    Qty DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    Price DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    Timestamp DATETIME NOT NULL,
    CONSTRAINT FK_OUser FOREIGN KEY (UserID) REFERENCES Account (UserID),
    CONSTRAINT FK_OMarket FOREIGN KEY (Pair) REFERENCES Market (Pair)
);

CREATE TABLE ExpressOrder (
    OrderID INT PRIMARY KEY,
    UserID INT NOT NULL,
    CurrencySymbol VARCHAR(20) NOT NULL,
    Qty DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    Price DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    BuySellIndicator VARCHAR(10) NOT NULL,
    Timestamp DATETIME NOT NULL,
    CONSTRAINT FK_EUser FOREIGN KEY (UserID) REFERENCES Account (UserID),
    CONSTRAINT FK_ECurrency FOREIGN KEY (CurrencySymbol) REFERENCES Currency (CurrencySymbol)
);

CREATE TABLE P2POrder (
    OrderID INT PRIMARY KEY,
    UserID INT NOT NULL,
    OfferedCurrencySymbol VARCHAR(20) NOT NULL,
    OfferedQty DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    RequestedPrice DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    RequiredCurrencySymbol VARCHAR(20) NOT NULL,
    FillerUserID INT,
    FilledQty DECIMAL(10,2) ,
    Status VARCHAR(50) NOT NULL,
    BuySellIndicator VARCHAR(10) NOT NULL,
    Timestamp DATETIME NOT NULL,
    CONSTRAINT FK_P2PUser FOREIGN KEY (UserID) REFERENCES Account (UserID),
    CONSTRAINT FK_OfferedCurrency FOREIGN KEY (OfferedCurrencySymbol) REFERENCES Currency (CurrencySymbol),
    CONSTRAINT FK_RequiredCurrency FOREIGN KEY (RequiredCurrencySymbol) REFERENCES Currency (CurrencySymbol),
    CONSTRAINT FK_FillerUser FOREIGN KEY (FillerUserID) REFERENCES Account (UserID)

);

CREATE TABLE Notification (
    NotificationID INT PRIMARY KEY,
    UserID INT NOT NULL,
    Timestamp DATETIME NOT NULL,
    Message TEXT,
    CONSTRAINT FK_NUser FOREIGN KEY (UserID) REFERENCES Account (UserID)
);


INSERT INTO `currency` (`CurrencyID`, `CurrencySymbol`, `CurrencyName`) VALUES
('Qwsogvtv82FCd', 'BTC', 'Bitcoin'),
('razxDUgYGNAdQ', 'ETH', 'Ethereum'),
('HIVsRcGKkPFtW', 'USDT', 'Tether USD'),
('WcwrkfNI4FUAe', 'BNB', 'BNB'),
('-l8Mn2pVlRsp', 'XRP', 'XRP'),
('zNZHO_Sjf', 'SOL', 'Solana'),
('aKzUVe4Hh_CON', 'USDC', 'USDC'),
('qzawljRxB5bYu', 'ADA', 'Cardano'),
('a91GCGd_u96cF', 'DOGE', 'Dogecoin'),
('PDKcptVnzJTmN', 'OKB', 'OKB'),
('dvUj0CzDZ', 'AVAX', 'Avalanche'),
('qUhEFk1I61atv', 'TRX', 'TRON'),
('CiixT63n3', 'wstETH', 'Wrapped liquid staked Ether 2.0'),
('VLqpJwogdhHNb', 'LINK', 'Chainlink'),
('25W7FG7om', 'DOT', 'Polkadot'),
('uW2tkILY0ii', 'MATIC', 'Polygon'),
('Mtfb0obXVh59u', 'WETH', 'Wrapped Ether'),
('x4WXHgevvFY', 'WBTC', 'Wrapped BTC'),
('xz24e0BjL', 'SHIB', 'Shiba Inu'),
('D7B1x_ks7WhV5', 'LTC', 'Litecoin'),
('_H5FVG9iW', 'UNI', 'Uniswap'),
('ZlZpzOJo43mIo', 'BCH', 'Bitcoin Cash'),
('MoTuySvg7', 'DAI', 'Dai'),
('ncYFcP709', 'CAKE', 'PancakeSwap'),
('67YlI0K1b', 'TON', 'Toncoin'),
('Knsels4_OlNy', 'ATOM', 'Cosmos'),
('3mVx2FX_iJFp5', 'XMR', 'Monero'),
('hnfQfsYfeIGUQ', 'ETC', 'Ethereum Classic'),
('V8GxkwWow', 'KAS', 'Kaspa'),
('Z96jIvLU7', 'IMX', 'Immutable X'),
('08CsQaOv', 'WEMIX', 'WEMIX Token'),
('f3iaFeCKEmkaZ', 'XLM', 'Stellar'),
('jad286TjB', 'HBAR', 'Hedera'),
('aMNLwaUbY', 'ICP', 'Internet Computer (DFINITY)'),
('ymQub4fuB', 'FIL', 'Filecoin'),
('ybmUkKU', 'RUNE', 'THORChain'),
('7C4Mh4xy1yDel', 'RNDR', 'Render Token'),
('Pe93bIOD2', 'LDO', 'Lido DAO Token'),
('FEbS54wxo4oIl', 'VET', 'VeChain'),
('vSo2fu9iE1s0Y', 'BUSD', 'Binance USD'),
('3nNpuxHJ8', 'FXS', 'Frax Share'),
('PkY9BmsyW', 'INJ', 'Injective Protocol'),
('65PHZTpmE55b', 'CRO', 'Cronos'),
('YQcD0lBl7', 'TIA', 'Celestia'),
('NfeOYfNcl', 'FTT', 'FTX Token'),
('ixgUfzmLR', 'AAVE', 'Aave'),
('Hm3OlynlC', 'TWT', 'Trust Wallet Token'),
('qFakph2rpuMOL', 'MKR', 'Maker'),
('DCrsaMv68', 'NEAR', 'NEAR Protocol'),
('AaQUAs2Mc', 'LUNC', 'Terra Classic');

INSERT INTO Account (Username, Email, Password, Name, IBAN)
VALUES
('admin', 'admin@example.com', 'admin', 'admin', 'admin'),
('user1', 'user1@example.com', 'user1', 'user1', 'user1'),
('user2', 'user2@example.com', 'user2', 'user2', 'user2'),
('user3', 'user3@example.com', 'user3', 'user3', 'user3');


INSERT INTO Wallet (WalletID, CurrencySymbol, Qty)
VALUES
(1, 'BTC', 5.0),
(1, 'ETH', 10.25),
(2, 'BTC', 8.75),
(2, 'LTC', 15.0),
(3, 'ETH', 20.5),
(3, 'USDT', 500.0);

INSERT INTO Wallet (WalletID, CurrencySymbol, Qty)
VALUES
(1, 'LTC', 7.0);