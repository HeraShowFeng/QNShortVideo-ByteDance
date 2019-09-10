package com.qiniu.shortvideo.bytedance.bytedance.fragment;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.qiniu.shortvideo.bytedance.R;
import com.qiniu.shortvideo.bytedance.bytedance.MainActivity;
import com.qiniu.shortvideo.bytedance.bytedance.base.IPresenter;
import com.qiniu.shortvideo.bytedance.bytedance.view.ButtonView;


/**
 * 距离估计Fragment
 */
public class HumanDistanceFragment
        extends BaseFeatureFragment<IPresenter, HumanDistanceFragment.IDistCallback>
        implements MainActivity.OnCloseListener, View.OnClickListener {
    private ButtonView bv;

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }


    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        return LayoutInflater.from(getActivity()).inflate(R.layout.fragment_human_distance, null);
    }

    @Override
    public void onViewCreated(final View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

        bv = view.findViewById(R.id.bv_distance);
        bv.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.bv_distance:
                boolean isDistanceOn = !bv.isOn();
                getCallback().distanceOn(isDistanceOn);
                bv.change(isDistanceOn);
                break;
        }
    }

    @Override
    public void onClose() {
        getCallback().distanceOn(false);

        bv.off();
    }

    /**
     * 距离检测相关设置回调接口，用于和FeatureBoardFragment通信
     */
    public interface IDistCallback {
        // 距离检测
        void distanceOn(boolean flag);
    }
}

