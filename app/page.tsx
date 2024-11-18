"use client";

import Image from "next/image";
import styles from "./page.module.css";
import React, { useState } from "react";

export default function Home() {
  const [selectedFile, setSelectedFile] = useState("");
  return (
    <div className={styles.page}>
      <main className={styles.main}>
        <form>
          <input
            type="file"
            value={selectedFile}
            onChange={(e) => setSelectedFile(e.target.files[0])}
          />
        </form>
      </main>
    </div>
  );
}
