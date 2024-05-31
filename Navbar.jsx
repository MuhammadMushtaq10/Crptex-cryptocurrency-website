import React, { useState } from 'react';
import { Menu, Typography, Avatar } from 'antd';
import { Link } from 'react-router-dom';
import {
    HomeOutlined,
    FundOutlined,
    MoneyCollectOutlined,
    WalletOutlined,
} from '@ant-design/icons';

import icon from '../images/favicon.svg';

const Navbar = () => {
    const [selectedKey, setSelectedKey] = useState('home');

    const handleMenuClick = (key) => {
        setSelectedKey(key);
    };

    return (
        <div className='nav-container'>
            <div className='logo-container'>
                <Avatar src={icon} size='large' />
                <Typography.Title level={2} className='logo'>
                    <Link to='/'>Cryptex</Link>
                </Typography.Title>
            </div>
            <Menu
                theme='dark'
                style={{ width: '100%' }}
                selectedKeys={[selectedKey]}
                onClick={({ key }) => handleMenuClick(key)}
            >
                <Menu.Item key='home' icon={<HomeOutlined />}>
                    <Link to='/'>Home</Link>
                </Menu.Item>
                <Menu.Item key='cryptocurrencies' icon={<FundOutlined />}>
                    <Link to='/cryptocurrencies'>Cryptocurrencies</Link>
                </Menu.Item>
                <Menu.SubMenu key='trades' icon={<MoneyCollectOutlined />} title='Trades'>

                    <Menu.Item key='trades'>
                        <Link to='/trades'>Trades</Link>
                    </Menu.Item>
                    <Menu.Item key='ExpressTrade'>
                        <Link to='/ExpressTrade'>Express Trading</Link>
                    </Menu.Item>
                    <Menu.Item key='SpotTrade'>
                        <Link to='/SpotTrade'>Spot Trading</Link>
                    </Menu.Item>
                    <Menu.Item key='P2PTrade'>
                        <Link to='/P2PTrade'>P2P Trading</Link>
                    </Menu.Item>
                </Menu.SubMenu>
                <Menu.Item key='wallet' icon={<WalletOutlined />}>
                    <Link to='/wallet'>Wallet</Link>
                </Menu.Item>
            </Menu>
            <Menu
                theme='dark'
                style={{
                    width: '100%',
                    position: 'absolute',
                    bottom: 20,
                    alignItems: 'center',
                    justifyContent: 'center',
                }}
                selectedKeys={[selectedKey]}
                onClick={({ key }) => handleMenuClick(key)}
            >
                <Menu.Item key='dashboard' icon={<WalletOutlined />}>
                    <Link to='/account'>Dashboard</Link>
                </Menu.Item>
                <Menu.Item key='login' icon={<WalletOutlined />}>
                    <Link to='/login'>Login / SignUp</Link>
                </Menu.Item>
            </Menu>
        </div>
    );
};

export default Navbar;
