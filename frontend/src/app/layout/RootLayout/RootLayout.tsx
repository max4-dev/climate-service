import {
  AppstoreOutlined,
  BuildOutlined,
  CalculatorOutlined,
  CodeSandboxOutlined,
  HomeOutlined,
  MenuFoldOutlined,
  MenuUnfoldOutlined,
  TagsOutlined
} from '@ant-design/icons';
import { Layout, Menu } from 'antd';
import { useState } from 'react';
import { Outlet, useLocation, useNavigate } from 'react-router';
import styles from './RootLayout.module.css';

const { Header, Sider, Content } = Layout;

export const RootLayout = () => {
  const [collapsed, setCollapsed] = useState(false);
  const navigate = useNavigate();
  const location = useLocation();

  const menuItems = [
    { key: '/', icon: <AppstoreOutlined />, label: 'Продукты' },
    { key: '/product-types', icon: <TagsOutlined />, label: 'Типы продукта' },
    { key: '/materials', icon: <CodeSandboxOutlined />, label: 'Материалы' },
    { key: '/workshops', icon: <HomeOutlined />, label: 'Мастерские' },
    { key: '/product-workshops', icon: <BuildOutlined />, label: 'Производства'},
    { key: '/calculator', icon: <CalculatorOutlined />, label: 'Калькулятор' }, 
  ];

  return (
    <Layout className={styles.rootLayout}>
      <Sider
        trigger={null}
        collapsible
        collapsed={collapsed}
        className={styles.sider}
      >
        <img src='/images/logo.png' className={styles.logo} />
        <Menu
          theme="dark"
          mode="inline"
          selectedKeys={[location.pathname]}
          items={menuItems}
          onClick={({ key }) => navigate(key)}
        />
      </Sider>

      <Layout>
        <Header className={styles.header}>
          <button
            type="button"
            className={styles.collapseButton}
            onClick={() => setCollapsed(!collapsed)}
          >
            {collapsed ? <MenuUnfoldOutlined /> : <MenuFoldOutlined />}
          </button>

          <div className={styles.headerRight}>Админка</div>
        </Header>

        <Content className={styles.content}>
          <Outlet />
        </Content>
      </Layout>
    </Layout>
  );
};
