import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { validateConfig } from './common/utils';
import { AuthModule } from './module/auth/auth.module';
import { RoleModule } from './module/role/role.module';
import { UserModule } from './module/user/user.module';
import { RequestModule } from './module/request/request.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      validate: (config) => validateConfig(config),
    }),
    AuthModule,
    UserModule,
    RoleModule,
    RequestModule,
  ],
})
export class AppModule {}
