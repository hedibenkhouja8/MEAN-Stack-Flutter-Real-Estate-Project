import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { RentComponent } from './rent.component';
import { CommonModule } from '@angular/common';
import { RentDetailsComponent } from './rent-details/rent-details.component';
import { ReactiveFormsModule, FormsModule } from '@angular/forms';

const routes: Routes = [
  { path: '', component: RentComponent },
{ path: ':id', component: RentDetailsComponent }];


@NgModule({
  imports: [
    RouterModule.forChild(routes),
    CommonModule,
    ReactiveFormsModule,
    FormsModule],
  exports: [
    RouterModule,
    FormsModule,
    ReactiveFormsModule
  ],
  declarations: [
    RentDetailsComponent
  ]
})
export class RentRoutingModule { }
