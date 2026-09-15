import { ReactNode } from "react";

export type Post = {
  id: number;
  title: string;
  body: string;
  author: number;
  posted: string;
  signature: null;
  realname: string;
  publickey: string;
}

export type User = {
  id: number;
  username: string;
  realname: string;
  role: string;
  publickey: string;
}

export type ProtectedRouteProps = {
  user: User | null;
  roles?: string[];
  children: ReactNode;
}