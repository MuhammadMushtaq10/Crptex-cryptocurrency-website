import React, { useState } from 'react';
import { Form, Input, Button, Upload, message } from 'antd';
import { UserOutlined, LockOutlined, MailOutlined, IdcardOutlined, CreditCardOutlined, InboxOutlined } from '@ant-design/icons';
import { Link } from 'react-router-dom/cjs/react-router-dom.min';
import axios from 'axios';
import Loader from './Loader';
import Homepage from './Homepage';

const { Dragger } = Upload;

const LoginPage = () => {
  const [imageUrl, setImageUrl] = useState(null);
  const [isLoginForm, setIsLoginForm] = useState(true);

  const toggleForm = () => {
    setIsLoginForm((prev) => !prev);
  };

  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [name, setName] = useState('');
  const [username, setUsername] = useState('');
  const [bankDetails, setBankDetails] = useState('');


  const handleLogin = () => {
    axios.post('http://localhost:8081/login', { email, password })
      .then(res => {
        console.log(res);
        if (res.data == "Login Successfully") {
          message.success('Login successful');
          return <Homepage />;

        }
        else
          message.error('Login failed. Please check your credentials.');

      })
      .catch(err => {
        console.log(err);
        message.error('Login failed. Please check your credentials.');
      });
  };

  const handleSignUp = () => {
    axios.post('http://localhost:8081/signup', { username, email, password, name, bankDetails })
      .then(res => {
        console.log(res);
        if (res.data == "Registration Successful")
          message.success('Sign up successful');
        else
          message.error('Sign up Failed. Please check your input data.');
      })
      .catch(err => {
        console.log(err);
        message.error('Sign up failed. Please try again.');
      });
  };

  const handleSubmit = (event) => {
    // event.preventDefault();

    if (isLoginForm) {
      handleLogin();
    } else {
      handleSignUp();
    }
  };


  const containerStyle = {
    display: 'flex',
    flexDirection: 'column',
    minHeight: '80vh', // Minimum height of the container to cover the whole viewport
  };

  const formContainerStyle = {
    flexGrow: 1, // Allow the content to grow to fill the remaining space
    maxWidth: '400px',
    margin: 'auto',
    padding: '20px',
    border: '1px solid #ddd',
    borderRadius: '8px',
    boxShadow: '0 0 10px rgba(0,0,0,0.1)',
  };

  const toggleButtonStyle = {
    display: 'block',
    textAlign: 'center',
  };


  return (
    <div style={containerStyle}>
      <div style={formContainerStyle}>
        <h1 style={{ textAlign: 'center', marginBottom: '20px' }}>{isLoginForm ? 'Login' : 'Sign Up'}</h1>

        <Form name={isLoginForm ? 'loginForm' : 'signupForm'} initialValues={{ remember: true }} onFinish={handleSubmit}>
          {!isLoginForm && (
            <Form.Item
              label="Username"
              name="username"
              rules={[{ required: true, message: 'Please input your username!' }]}
            >
              <Input prefix={<IdcardOutlined />} placeholder="Username" onChange={e => setUsername(e.target.value)} />
            </Form.Item>
          )}

          <Form.Item
            label="Email"
            name="email"
            rules={[{ required: true, message: 'Please input your email!' }]}
          >
            <Input prefix={<MailOutlined />} type="email" placeholder="Email" onChange={e => setEmail(e.target.value)} />
          </Form.Item>

          <Form.Item
            label="Password"
            name="password"
            rules={[{ required: true, message: 'Please input your password!' }]}
          >
            <Input.Password prefix={<LockOutlined />} placeholder="Password" onChange={e => setPassword(e.target.value)} />
          </Form.Item>

          {!isLoginForm && (
            <Form.Item
              label="Name"
              name="name"
              rules={[{ required: true, message: 'Please input your name!' }]}
            >
              <Input prefix={<UserOutlined />} placeholder="Name" onChange={e => setName(e.target.value)} />
            </Form.Item>
          )}

          {!isLoginForm && (
            <Form.Item
              label="IBAN"
              name="bankDetails"
              rules={[{ required: true, message: 'Please input your bank account details!' }]}
            >
              <Input prefix={<CreditCardOutlined />} placeholder="Bank Account Details" onChange={e => setBankDetails(e.target.value)} />
            </Form.Item>
          )}

          {/* {!isLoginForm && (
          <Form.Item
            label="Profile Image"
            name="profileImage"
            valuePropName="fileList"
            getValueFromEvent={(e) => e.fileList}
            rules={[{ required: false }]}
          >
            <Dragger
              name="file"
              showUploadList={false}
              customRequest={({ file, onSuccess }) => {
                // Mock upload logic
                setTimeout(() => {
                  onSuccess();
                }, 0);
              }}
              onChange={handleImageChange}
            >
              <p className="ant-upload-drag-icon">
                <InboxOutlined />
              </p>
              <p className="ant-upload-text">Click or drag file to this area to upload</p>
            </Dragger>
          </Form.Item>
        )} */}

          <Form.Item>
            <Button type="primary" htmlType="submit" style={{ width: '100%' }}>
              {isLoginForm ? 'Login' : 'Sign Up'}
            </Button>
          </Form.Item>
        </Form>
      </div>
      <Button type="link" onClick={toggleForm} style={toggleButtonStyle}>
        {isLoginForm ? 'Switch to Sign Up' : 'Switch to Login'}
      </Button>
    </div >
  );
};

export default LoginPage;