import './globals.css';
export const metadata = { title: 'PluggyGo Admin', description: 'PluggyGo operations dashboard' };
export default function RootLayout({children}:{children:React.ReactNode}) { return <html lang="en"><body>{children}</body></html>; }
