import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { UsersComponent } from './users.component';
import { UserDetailsComponent } from './user-details/user-details.component';
import { CommonModule } from '@angular/common';

const routes: Routes = [
  { path: '', component: UsersComponent },
 
  { path: ':id', component: UserDetailsComponent }
];

@NgModule({
  imports: [RouterModule.forChild(routes),CommonModule],
  exports: [RouterModule],
  declarations: [
    UserDetailsComponent
  ]
})
export class UsersRoutingModule { }
