import { Injectable } from '@angular/core';

import { AuthService } from "src/app/services/auth.service";
import {
  HttpRequest,
  HttpHandler,
  HttpEvent,
  HttpInterceptor
} from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable()
export class AuthInterceptor implements HttpInterceptor {

  constructor(
    private authService: AuthService
  ) {}
  intercept(request: HttpRequest<unknown>, next: HttpHandler): Observable<HttpEvent<unknown>> {
    const accessToken = this.authService.getAccessToken();
    request = request.clone({
      setHeaders: {   
      Authorization: `Bearer ${accessToken}`,
      //userId: this.authService.getUserId()
      }
    });
    return next.handle(request);

  }
}
